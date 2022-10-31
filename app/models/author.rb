# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :questions, -> { where(question_id: nil) }, class_name: 'Post'
  has_many :answers, -> { where.not(question_id: nil) }, class_name: 'Post'

  ## =====> Hello, Interviewers!
  #
  # Gravitar supports identicons, unique pictures based on
  # a hashed (email) value.
  # I wanted my fake people to have varied identicons
  # And didn't need them to have an email address for anything
  # So I'm just faking the hashed return straight to the URL
  # I was generating 32-bit alphanumerics at one point, but
  # there's a threshold of complexity that returns the same
  # identicon once exceeded.
  # Surprisingly, 8-bit, number-only strings give the most varied results.
  def initialize(*args)
    super

    self.name ||= Faker::Name.unique.name
    self.reputation ||= Faker::Number.unique.between(from: 0, to: 999)
    self.gravatar_url ||= "https://www.gravatar.com/avatar/#{Faker::Number.unique.number(digits: 8)}?s=48&d=identicon&r=PG"

    set_badges
  end

  # Convenience function for changing the Gravatar image
  def change_identicon!
    self.gravatar_url = "https://www.gravatar.com/avatar/#{Faker::Number.unique.number(digits: 8)}?s=48&d=identicon&r=PG"

    save
    reload.gravatar_url
  end

  def change_reputation!
    self.reputation = Faker::Number.unique.between(from: 0, to: 999)

    save
    reload.reputation
  end

  def set_badges
    self.gold =   Faker::Number.between(from: 0, to: 5)
    self.silver = Faker::Number.between(from: 0, to: 18)
    self.bronze = Faker::Number.between(from: 0, to: 50)
  end
end
