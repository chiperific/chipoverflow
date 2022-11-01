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
    UpdateReputationJob.perform_now if Chip.reputation.zero?

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

  def redirect_to_question(post)
    if post.is_question?
      redirect_to show_post_path(post.id, post.title_slug)
    else
      redirect_to show_post_path(post.question.id, post.question.title_slug)
    end
  end
end
