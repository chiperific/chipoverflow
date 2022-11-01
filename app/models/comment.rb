# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :post

  validates_presence_of :body

  has_rich_text :body

  before_create :create_author, if: -> { author_id.nil? }
  before_create :set_rank

  def for_seed
    {
      post_id: post_id,
      body: body.to_trix_html
    }
  end

  private

  def create_author
    self.author = Author.create
  end

  def set_rank
    self.rank = Time.now.to_i
  end
end
