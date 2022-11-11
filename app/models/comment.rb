# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :post

  validates_presence_of :body

  has_rich_text :body

  before_create :create_author, if: -> { author_id.nil? }
  before_create :set_published_at, if: -> { published_at.nil? }

  after_save :update_tags_scores

  def for_seed
    {
      post_id: post_id,
      body: body.to_trix_html,
      votes: votes,
      published_at: published_at.to_s
    }
  end

  def randomly_increase_votes!
    # there shouldn't be more votes on the comment than there are votes on the post
    upper = [2, post.votes].max
    self.votes += Random.rand(1..upper)

    save
  end

  private

  def create_author
    self.author = Author.create
  end

  def set_published_at
    # comments shouldn't be published before their parent post
    self.published_at = Faker::Time.between(from: post.published_at, to: Time.now)
  end

  def update_tags_scores
    UpdateTagScoresJob.perform_now
  end
end
