# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should belong_to :author
  should have_many(:comments).dependent(:destroy)
  should have_many(:answers).class_name('Post').with_foreign_key(:question_id).dependent(:destroy)
  should belong_to(:question).class_name('Post')
  should should have_and_belong_to_many(:tags)

  context '#has_accepted_answer?' do
    context 'when post is an answer' do
      should 'return false' do
        assert_equal false, posts(:valid_answer).has_accepted_answer?
      end
    end

    context 'when post is a question' do
      context 'with no associated answers.where(accepted: true)' do
        setup do
          @question = posts(:valid_question)
          Post.only_answers.destroy_all
        end

        should 'return false' do
          assert_equal false, @question.has_accepted_answer?
        end
      end

      context 'with at least one associated answers.where(accepted: true)' do
        should 'return true' do
          @accepted_answer = posts(:valid_accepted_answer)
          @question = @accepted_answer.question

          assert_equal true, @accepted_answer.accepted?
          assert_equal true, @question.has_accepted_answer?
        end
      end
    end
  end

  context '#has_answer?' do
    context 'when post is an answer' do
      should 'return false' do
        assert_equal false, posts(:valid_answer).has_answers?
      end
    end

    context 'when post is a question' do
      context 'with no associated answers' do
        setup do
          @question = posts(:valid_question)
          Post.only_answers.destroy_all
        end

        should 'return false' do
          assert_equal false, @question.has_answers?
        end
      end

      context 'with at least one associated answers' do
        should 'return true' do
          @question = posts(:valid_answer).question
          assert_equal true, @question.has_answers?
        end
      end
    end
  end

  context '#is_accepted_answer?' do
    context 'when is_answer? && accepted?' do
      should 'return true' do
        assert_equal true, posts(:valid_accepted_answer).is_accepted_answer?
      end
    end

    context 'when either !is_answer? || !accepted?' do
      should 'return false' do
        assert_equal false, posts(:valid_question).is_accepted_answer?
        assert_equal false, posts(:valid_answer).is_accepted_answer?
      end
    end
  end

  context '#is_answer?' do
    context 'when question_id.present?' do
      should 'return true' do
        assert_equal true, posts(:valid_answer).is_answer?
      end
    end

    context 'when !question_id.present?' do
      should 'return false' do
        assert_equal false, posts(:valid_question).is_answer?
      end
    end
  end

  context '#create_author' do
    should 'create and assign an Author' do
      post = Post.new

      assert_nil post.author_id

      post.__send__(:create_author)

      assert_not_nil post.author_id
    end
  end

  context '#ensure_single_accepted_answer' do
    should 'change sibling answers to accepted:false' do
      question = posts(:valid_question)
      question.answers.update_all(accepted: true)
      first_answer = question.answers.first
      second_answer = question.answers.last

      assert_equal true, question.answers.where(accepted: true).size > 1

      first_answer.update(title: 'the real answer')

      assert_equal true, first_answer.reload.accepted?
      assert_equal false, second_answer.reload.accepted?
    end
  end
end
