# frozen_string_literal: true

require 'json'
require 'net/http'
require 'stringio'
require 'zlib'

## =====> Hello, Interviewers!
## Stack Overflow's profile HTML sits behind a Cloudflare JS challenge now,
## so Net::HTTP + Nokogiri only ever see "Just a moment...".
## The public Stack Exchange API returns reputation and badge counts as JSON.
## No key required. Anonymous quota is 300 requests/day, and the body is gzip.
## Flow:
# * Skip the request if reputation was refreshed within the last day
# * GET /2.3/users/:so_id?site=stackoverflow
# * Gunzip and parse the first item
# * Bail out if reputation or any badge count is missing
# * Update the Chip record and stamp reputation_updated_at
class UpdateReputationJob < ApplicationJob
  REFRESH_AFTER = 1.day
  private_constant :REFRESH_AFTER

  def perform
    return if fresh?

    user = fetch_user
    return if user.nil?

    badges = user['badge_counts'] || {}
    update_hsh = {
      reputation: user['reputation'],
      gold: badges['gold'],
      silver: badges['silver'],
      bronze: badges['bronze']
    }

    return if update_hsh.values.any?(&:nil?)

    update_hsh[:reputation_updated_at] = Time.current

    Chip.update(update_hsh)
  end

  private

  def fresh?
    updated_at = Chip.reputation_updated_at
    updated_at.present? && updated_at > REFRESH_AFTER.ago && !Chip.reputation.zero?
  end

  def fetch_user
    uri = URI("https://api.stackexchange.com/2.3/users/#{Chip.so_id}?site=stackoverflow")
    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'
    request['Accept-Encoding'] = 'gzip'
    request['User-Agent'] = 'chipoverflow'

    response =
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: 5, read_timeout: 5) do |http|
        http.request(request)
      end

    return unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(decode_body(response)).dig('items', 0)
  rescue JSON::ParserError, Zlib::Error, IOError, SystemCallError, Timeout::Error, OpenSSL::SSL::SSLError
    nil
  end

  def decode_body(response)
    raw = response.body.to_s
    gzipped = response['Content-Encoding'].to_s.casecmp('gzip').zero? || raw.start_with?("\x1F\x8B".b)
    return raw unless gzipped

    Zlib::GzipReader.new(StringIO.new(raw)).read
  end
end
