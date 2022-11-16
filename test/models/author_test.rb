# frozen_string_literal: true

require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  subject { authors(:valid) }

  context 'initialization' do
    context 'with no details provided' do
      should allow_value(nil).for(:name)
      should allow_value(nil).for(:reputation)
      should allow_value(nil).for(:gravatar_url)

      should 'assign a name' do
        assert subject.name.present?, 'Author name was not present'
      end

      should 'assign a reputation' do
        assert subject.reputation.present?, 'Author reputation was not present'
      end

      should 'assign an gravatar_url' do
        assert subject.gravatar_url.present?, 'Author gravatar_url was not present'
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
          gravatar_url: @fixture_author.gravatar_url
        )
      end

      should 'assign the given name' do
        assert_equal @fixture_author.name, subject.name, 'Author name did not match fixture name value'
      end

      should 'assign the given reputation' do
        assert_equal @fixture_author.reputation, subject.reputation, 'Author reputation did not match fixture reputation value'
      end

      should 'assign the given gravatar_url' do
        assert_equal @fixture_author.gravatar_url, subject.gravatar_url, 'Author gravatar_url did not match fixture gravatar_url value'
      end
    end
  end

  context '#for_seed' do
    should 'be a hash' do
      assert_equal Hash, subject.for_seed.class
    end

    should 'have 7 items' do
      assert_equal 7, subject.for_seed.size
    end
  end

  context '#change_gravatar!' do
    should 'change the gravatar URL field' do
      assert_not_equal subject.gravatar_url, subject.change_gravatar!
    end
  end

  context '#change_reputation!' do
    should 'change the reputation field' do
      assert_not_equal subject.reputation, subject.change_reputation!
    end
  end

  context '#set_badges' do
    should 'change the badges fields' do
      first_gold = subject.gold
      first_silver = subject.silver
      first_bronze = subject.bronze

      subject.set_badges

      assert_not_equal first_gold, subject.gold
      assert_not_equal first_silver, subject.silver
      assert_not_equal first_bronze, subject.bronze
    end
  end
end
