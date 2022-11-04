# frozen_string_literal: true

##
# A post can be a question or an answer
# Answers are associated with a question (question_id is present)
# Questions have question_id: nil
#
class Post < ApplicationRecord
  belongs_to :author, optional: true
  has_many :comments, dependent: :destroy
  has_many :answers, class_name: 'Post', foreign_key: 'question_id', dependent: :destroy
  belongs_to :question, class_name: 'Post', optional: true
  has_and_belongs_to_many :tags

  has_rich_text :body

  scope :only_questions, -> { where(question_id: nil).order(rank: :asc) }
  scope :only_answers, -> { where.not(question_id: nil).order(rank: :asc) }
  scope :with_body_containing, ->(query) { joins(:rich_text_body).merge(ActionText::RichText.with_body_containing(query)) }
  scope :with_title_containing, ->(query) { where('LOWER(title) ILIKE any ( array[?] )', query.split.map { |v| "%#{v.downcase}%" }) }
  scope :containing, ->(query) { with_body_containing(query).or(with_title_containing(query)) }
  scope :ordered_randomly, -> { order(Arel.sql('RANDOM()')) }

  before_save :create_author, if: -> { author.nil? }
  before_save :set_title_slug, if: -> { will_save_change_to_title? }
  before_create :set_rank

  after_update :ensure_single_accepted_answer, if: -> { accepted? }

  def body_plain_text
    body.plain_text_body.gsub("\n", '')
  end

  ## Temp function to generate development data for the seed file
  # run Post.all.map { |r| p r.for_seed }
  #
  def for_seed
    {
      id: id,
      title: title,
      title_slug: title_slug,
      body: body.to_trix_html,
      question_id: question_id,
      accepted: accepted,
      views: views,
      votes: votes,
      rank: rank
    }
  end

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

  def is_question?
    question_id.nil?
  end

  def modified?
    created_at.to_i < updated_at.to_i
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

  def set_title_slug
    # remove trailing and excessive whitespace
    # remove non-word, non-space characters
    # keep only the first 8 words
    ary = title.squish
               .remove(Constants::SYM_REGEX)
               .split[0..7]

    # remove stop words
    # replace spaces with dashes
    self.title_slug = (ary - Constants::STOP_WORDS).join('-')
  end

  def set_rank
    self.rank = (Time.now.to_i / 8)
  end
end
