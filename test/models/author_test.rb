# frozen_string_literal: true

require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test 'is assigned a name at initialization' do
    author = Author.new
    assert author.name.present?
  end
end
