# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :questions, -> { where(question_id: nil) }, class_name: 'Post'
  has_many :answers, -> { where.not(question_id: nil) }, class_name: 'Post'

  def initialize(*args)
    super

    self.name = Faker::Name.name
    self.reputation = Faker::Number.number(digits: 4)
    self.identicon_url = "https://www.gravatar.com/avatar/#{Faker::Alphanumeric.alphanumeric(number: 32)}?s=48&d=identicon&r=PG"

    save
    reload
  end
end
