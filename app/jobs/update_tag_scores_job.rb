# frozen_string_literal: true

class UpdateTagScoresJob < ApplicationJob
  def perform
    Tag.all.each(&:calculate_score!)
  end
end
