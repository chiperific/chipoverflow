# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_badges
  before_action :set_left_sidebar_highlighting

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

  def set_left_sidebar_highlighting
    @highlight_home = action_name == 'homepage'
    @highlight_questions = action_name == 'show' && controller_name == 'posts'

    # TODO: fill in with more navigations
  end
end
