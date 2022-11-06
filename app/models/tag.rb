# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates_presence_of :name

  def questions
    posts.only_questions
  end

  def for_seed
    {
      id: id,
      name: name,
      score: score
    }
  end
end
