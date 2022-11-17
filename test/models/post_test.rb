# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  subject { posts(:valid_question) }

  context '#body_plain_text' do
    should 'return a string representation of the body' do
      assert_equal String, subject.body_plain_text.class
    end
  end

  context '#for_seed' do
    should 'return a Hash' do
      assert_equal Hash, subject.for_seed.class
    end

    should 'contain the important parts of a Post' do
      assert_equal 11, subject.for_seed.size
    end
  end

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

  context '#is_question?' do
    context 'when question_id.present?' do
      should 'return false' do
        assert_equal false, posts(:valid_answer).is_question?
      end
    end

    context 'when !question_id.present?' do
      should 'return true' do
        assert_equal true, posts(:valid_question).is_question?
      end
    end
  end

  context 'randomly_increase_votes_and_views!' do
    should 'increase votes field' do
      first_views = subject.views
      first_votes = subject.votes

      subject.randomly_increase_votes_and_views!
      subject.reload

      assert_operator first_views, :<, subject.views
      assert_operator first_votes, :<, subject.votes
    end
  end

  context 'recalculate_rank!' do
    should 'change the value of rank based upon votes and views' do
      first_rank = subject.rank
      subject.update_columns(views: 25, votes: 5)
      subject.reload.recalculate_rank!

      assert_operator first_rank, :<, subject.reload.rank
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
