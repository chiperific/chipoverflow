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

  scope :only_questions, -> { where(question_id: nil) }
  scope :only_answers, -> { where.not(question_id: nil) }
  scope :with_body_containing, ->(query) { joins(:rich_text_body).merge(ActionText::RichText.with_body_containing(query)) }
  scope :with_title_containing, ->(query) { where('LOWER(title) ILIKE any ( array[?] )', query.split.map { |v| "%#{v.downcase}%" }) }
  scope :containing, ->(query) { with_body_containing(query).or(with_title_containing(query)) }
  scope :ordered_randomly, -> { order(Arel.sql('RANDOM()')) }

  scope :ordered_by_date, -> { order(published_at: :asc) }
  scope :ordered_by_rank, -> { order(rank: :desc) }

  before_save :create_author, if: -> { author.nil? }
  before_save :set_title_slug, if: -> { will_save_change_to_title? }
  before_create :set_published_at, if: -> { published_at.nil? }

  before_update :add_vote_to_rank, if: -> { will_save_change_to_votes? }
  before_update :add_view_to_rank, if: -> { will_save_change_to_views? }

  after_update :ensure_single_accepted_answer, if: -> { accepted? }

  after_save :update_tags_scores

  def body_plain_text
    body.plain_text_body.gsub("\n", '')
  end

  def for_seed
    {
      id: id,
      author_id: author_id,
      title: title,
      title_slug: title_slug,
      body: body.to_trix_html,
      question_id: question_id,
      accepted: accepted,
      views: views,
      votes: votes,
      rank: rank,
      published_at: published_at.to_s
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

  def randomly_increase_votes_and_views!
    # answers routinely get more votes than questions
    weight = is_answer? ? 45 : 25

    self.views += Random.rand(1..weight)

    # there shouldn't be more votes than views
    upper = [2, (views / 2)].max
    self.votes += Random.rand(1..upper)

    recalculate_rank!
  end

  def recalculate_rank!
    update(rank: (votes * 3) + views)
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

  def set_published_at
    # answers shouldn't be published before their question
    self.published_at =
      if is_question?
        Faker::Time.backward(days: 14)
      else
        Faker::Time.between(from: question.published_at, to: Time.now)
      end
  end

  def add_view_to_rank
    self.rank += 1
  end

  def add_vote_to_rank
    self.rank += votes > votes_was ? 3 : -3
  end

  def update_tags_scores
    UpdateTagScoresJob.perform_now
  end
end
