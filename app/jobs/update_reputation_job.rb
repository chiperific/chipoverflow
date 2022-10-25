# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

## =====> Hello, Interviewers!
## Who needs an API when you have Nokogiri and a bunch of free time?
# StackOverflow doesn't have a public API
# StackOverflow user profile pages don't respond to `.json` or '.xml'
#    extensions, only HTML5
# Stack Overflow doesn't use too many DOM IDs,
#    so I'm relyin on these brittle classes to
#    find the correct element nodes
## Flow:
# * Pull the entire HTML of my profile page on Stack Overflow
# * Parse the page with Nokogiri
# * Create a hash of the badges by color and reputation
# * Bail out early if the hash has a `nil` value
#     - a `nil` would come from Nokogiri failing to find an expected value
# * Update the Chip record with the new values, and an added timestamp
class UpdateReputationJob < ApplicationJob
  def perform
    uri = URI('https://stackoverflow.com/users/1880203/chiperific')
    page = Net::HTTP.get(uri)

    parsed_page = Nokogiri::HTML.parse(page)

    badge_titles = parsed_page.css('.flex--item .fs-caption')
    badge_counts = parsed_page.css('.fs-title.fw-bold.fc-black-800')

    update_hsh = {}

    badge_titles.each_with_index do |elem, index|
      update_hsh[elem.text.strip.gsub(' badges', '').to_sym] = badge_counts[index].text.strip.to_i
    end

    update_hsh[:reputation] = parsed_page.at_css('#stats div.fs-body3').text.strip.gsub(',', '').to_i

    return if update_hsh.values.map(&:nil?)

    update_hsh[:reputation_updated_at] = Time.now

    Chip.first.update(update_hsh)
  end
end
