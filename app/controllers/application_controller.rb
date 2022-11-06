# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_badges
  before_action :set_left_sidebar_highlighting

  def homepage
    UpdateReputationJob.perform_now

    @questions = Post.includes(:author).only_questions.ordered_by_rank
    @question_count = @questions.size
  end

  def sign_in; end

  def show_phone
    render 'phone_modal', layout: false
  end

  def contact
    # HTML5 validations prevent blank params
    ContactMailer.notify_owner(email_params[:email], email_params[:message]).deliver

    head :ok
  end

  private

  def email_params
    params.permit(:email, :message)
  end

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

  # =====> Hello, Interviewers!
  #
  # SO does useful back-end things with upvotes, downvotes, flags, and bookmarks
  # For my use case, I YAGNI'd almost all of that (but Posts do get vote tallies)
  # I am recording these state changes in the browser session cookies
  # So I can indicate all these actions per user without actually making
  # database calls
  # This was a great chance to try out Rails 7 Stimulus controllers for the first time
  def add_session_record(post_id, state_name, klass)
    session[klass] = {} if session[klass].nil?
    session[klass][state_name] = [] if session[klass][state_name].nil?

    session[klass][state_name] << post_id
  end

  def remove_session_record(post_id, state_name, klass)
    session[klass] = {} if session[klass].nil?
    session[klass][state_name] = [] if session[klass][state_name].nil?

    session[klass][state_name] -= [post_id]
  end
end
