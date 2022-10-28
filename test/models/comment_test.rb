# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  subject { comments(:valid) }

  setup do
    @comment =
      Comment.new(
        post: posts(:valid_question),
        body: '<div>Hello, from <strong>a fixture</strong></div>'
      )
  end

  should belong_to(:author).optional
  should belong_to :post

  should validate_presence_of :body

  context 'creating without an author' do
    should 'create an author and associate it with the record' do
      assert_nil @comment.author_id

      @comment.save

      assert_not_nil @comment.reload.author_id
    end
  end

  context 'creating without a rank' do
    should 'associate an integer with the record' do
      assert_nil @comment.rank

      @comment.save

      assert_equal true, @comment.reload.rank.is_a?(Integer)
    end
  end
end
