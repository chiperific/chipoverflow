# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates_presence_of :name

  scope :ordered_by_score, -> { order(score: :desc) }
  scope :ordered_by_name, -> { order(name: :asc) }
  scope :matching_search, ->(query) { where('name ILIKE ?', "%#{query}%") }

  def questions
    posts.only_questions
  end

  def for_seed
    {
      id: id,
      name: name,
      description: description,
      score: score
    }
  end

  def calculate_score!
    self.score = 0

    questions.each do |q|
      self.score += 10
      self.score += 5 if q.has_accepted_answer?
      self.score += 3 if q.has_answers?
      self.score += q.comments.size
    end

    save
    reload
    score
  end
end
