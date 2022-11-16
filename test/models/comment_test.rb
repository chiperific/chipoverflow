# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  subject { Comment.new(body: 'Hello from <strong>Mini::Test</strong>', post: posts(:valid_question)) }

  context 'creating without an author' do
    should 'create an author and associate it with the record' do
      assert_nil subject.author_id

      subject.save

      assert_not_nil subject.reload.author_id
    end
  end

  context 'creating without a published time' do
    should 'set a time between post.published_at and now' do
      assert_nil subject.published_at

      subject.save
      subject.reload

      assert_not_nil subject.published_at

      assert_operator Time.now, :>, subject.published_at
      assert_operator subject.post.published_at, :<, subject.published_at
    end
  end

  context '#for_seed' do
    should 'return a Hash' do
      assert_equal Hash, subject.for_seed.class
    end

    should 'include important fields' do
      assert_equal 5, subject.for_seed.size
    end
  end

  context '#randomly_increase_votes!' do
    should 'increase the number of votes' do
      assert_operator subject.votes, :<, subject.randomly_increase_votes!
    end
  end
end
