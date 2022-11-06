# frozen_string_literal: true

require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  subject { Author.new }

  should have_many :posts
  should have_many :comments
  should have_many :questions
  should have_many :answers

  context 'initialization' do
    context 'with no details provided' do
      should allow_value(nil).for(:name)
      should allow_value(nil).for(:reputation)
      should allow_value(nil).for(:identicon_url)

      should 'assign a name' do
        assert subject.name.present?, 'Author name was not present'
      end

      should 'assign a reputation' do
        assert subject.reputation.present?, 'Author reputation was not present'
      end

      should 'assign an identicon_url' do
        assert subject.identicon_url.present?, 'Author identicon_url was not present'
      end
    end

    context 'with provided details' do
      setup do
        @fixture_author = authors(:valid)
      end

      subject do
        Author.new(
          name: @fixture_author.name,
          reputation: @fixture_author.reputation,
          identicon_url: @fixture_author.identicon_url
        )
      end

      should 'assign the given name' do
        assert_equal @fixture_author.name, subject.name, 'Author name did not match fixture name value'
      end

      should 'assign the given reputation' do
        assert_equal @fixture_author.reputation, subject.reputation, 'Author reputation did not match fixture reputation value'
      end

      should 'assign the given identicon_url' do
        assert_equal @fixture_author.identicon_url, subject.identicon_url, 'Author identicon_url did not match fixture identicon_url value'
      end
    end
  end
end
