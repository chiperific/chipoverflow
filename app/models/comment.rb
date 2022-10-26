# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post

  validates_presence_of :body

  before_save :create_author, if: -> { author.nil? }

  private

  def create_author
    self.author = Author.new
  end
end
