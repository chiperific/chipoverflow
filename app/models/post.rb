# frozen_string_literal: true

##
# A post can be a question or an answer
# Answers are associated with a question (question_id is present)
# Questions have question_id: nil
#
class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :answers, class_name: 'Post', foreign_key: 'question_id', dependent: :destroy
  belongs_to :question, class_name: 'Post'
  has_and_belongs_to_many :tags

  scope :only_questions, -> { where(question_id: nil) }
  scope :only_answers, -> { where.not(question_id: nil) }

  before_save :create_author, if: -> { author.nil? }

  after_update :ensure_single_accepted_answer, if: -> { accepted? }

  def has_accepted_answer?
    # answers don't have answers
    return false if is_answer?

    answers.where(accepted: true).any?
  end

  def has_answers?
    # answers don't have answers
    return false if is_answer?

    answers.size.positive?
  end

  def is_accepted_answer?
    is_answer? && accepted?
  end

  def is_answer?
    question_id.present?
  end

  def siblings
    Post.where(question_id: question_id).where.not(id: id)
  end

  private

  def create_author
    self.author = Author.create
  end

  def ensure_single_accepted_answer
    siblings.where(accepted: true)
            .update_all(accepted: false)
  end
end
