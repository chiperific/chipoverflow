# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_badges

  def homepage
    UpdateReputationJob.perform_now

    @questions = Post.includes(:author).only_questions
    @question_count = @questions.size
  end

  private

  def set_badges
    @reputation = Chip.reputation
    @gold_badges = Chip.gold
    @silver_badges = Chip.silver
    @bronze_badges = Chip.bronze
  end
end
