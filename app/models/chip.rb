# frozen_string_literal: true

## =====> Hello, Interviewers!
## Metaprogramming Butchery: Make the class act like the only instance
# There is only one Chip (despite what the phonebook says).
# Having to do `@chip = Chip.first` is dumb
# I am a proper noun and expect to be treated like one.
#
# Note: I know this is a terrible design pattern for ANY situation.
# I'm only doing this to show that I have some grasp on metaprogramming.
class Chip < ApplicationRecord
  # rubocop:disable Style/ClassVars

  # Weird how this method HAS to come before any call to it, but yeah...
  # try moving it down below `@@record = assign_record` into the class and
  # see what happens. Spoiler: method_missing
  def self.assign_record
    return first if any?

    Chip.create(
      name: 'Chip Kragt',
      phone: '616.528.8140',
      gravatar_url: 'https://www.gravatar.com/avatar/5c7a5fcd85529e17f9aa86c1e9a5490e?s=48&d=identicon&r=PG',
      so_id: 1_880_203
    )
  end

  @@record = assign_record
  @@keys = @@record.attributes.keys.map(&:to_sym)

  class << self
    @@keys.each do |k|
      define_method(k) do
        @@record.public_send(k)
      end
    end

    @@record
  end

  def self.update(args)
    # Mini::Test can get out of sync with setup and teardowns
    @@record = assign_record if Rails.env.test?

    @@record.update(args)
  end

  validate :highlander_clause, if: :new_record?

  private

  def highlander_clause
    return if Chip.all.size.zero?

    # refuse to make more of me.
    errors.add(:name, 'There can be only one Chip here.')
    false
  end

  @@record
  # rubocop:enable Style/ClassVars
end
