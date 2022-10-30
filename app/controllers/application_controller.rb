# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def homepage
    UpdateReputationJob.perform_now

    @reputation = Chip.reputation
    @gold_badges = Chip.gold
    @silver_badges = Chip.silver
    @bronze_badges = Chip.bronze

    @questions = Post.includes(:author).only_questions
    @question_count = @questions.size
  end
end
