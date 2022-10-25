# frozen_string_literal: true

## =====> Hello, Interviewers!
## Metaprogramming Butchery: Make the class act like the only instance
# There is only one Chip. Despite what the phonebook says
# Having to do `@chip = Chip.first` is dumb
# I want to do `Chip.address` etc.
#
# Note: this is a terrible design patter for ANY other situation.
# I'm allowed to do it because I want to show off that I can
# take a butcher's knife to Ruby if necessary.
#
# Concessions made:
# - adding a `def update(*args)` method causes a stack trace
class Chip < ApplicationRecord
  RECORD = Chip.first
  KEYS = RECORD.attributes.keys.map(&:to_sym)

  class << self
    KEYS.each do |k|
      define_method(k) do
        RECORD.public_send(k)
      end
    end

    RECORD
  end

  def update_record(*args)
    RECORD.update(*args)
  end
end
