# frozen_string_literal: true

## =====> Hello, Interviewers!
## Metaprogramming Butchery: Make the class act like the only instance
# There is only one Chip. Despite what the phonebook says
# Having to do `@chip = Chip.first` is dumb
# I want to do `Chip.address` etc.
#
# Note: this is a terrible design patter for ANY situation.
# I'm only doing this because I want to show that I have some grasp
# on metaprogramming.
#
# I considered just having a Chip class with hard-coded methods/attributes,
# but I wanted to be able to update reputation and badges from
# Stack Overflow, so I needed a database record to store them onto.
class Chip < ApplicationRecord
  # rubocop:disable Style/ClassVars

  # Weird how this method HAS to come before any call to it, but yeah...
  # try moving it down below `@@record =` into the class and
  # see what happens.
  def self.assign_record
    return first if any?

    Chip.create(
      name: 'Chip Kragt',
      phone: '616.528.8140',
      address: '1001 Alexander St SE, Grand Rapids, MI 49507',
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
    @@record.update(args)
  end

  validate :highlander_clause
  before_destroy :immortality_clause

  private

  def highlander_clause
    # refuse to make more of me.
    return if id == @@record.id

    errors.add(:name, 'There can be only one Chip here.')
    false
  end

  def immortality_clause
    # refuse to delete the first instance of me.
    return false if self == Chip.first
  end

  @@record
  # rubocop:enable Style/ClassVars
end
