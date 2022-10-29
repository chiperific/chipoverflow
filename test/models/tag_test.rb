# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should have_and_belong_to_many :posts
  should validate_presence_of :name
end
