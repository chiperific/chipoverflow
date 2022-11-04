# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update vote bookmark]
  def new
    @post = Post.new(question_id: question_params)

    @question = Post.find(question_params) if question_params.present?
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      @post.reload
      redirect_to_question(@post)
    else
      render :new
    end
  end

  def edit
    @question = @post.question if @post.is_answer?
  end

  def update
    if @post.update(post_params)
      redirect_to_question(@post)
    else
      render :edit
    end
  end

  def show
    @post.update_column(:views, @post.views += 1)

    @answer_sort_options =
      [
        ['Highest score (default)', 'scoredesc'],
        ['Date modified (newest first)', 'modifieddesc'],
        ['Date created (oldest first)', 'createdasc']
      ]

    @answers = @post.answers.order(rank: :desc)
  end

  def search
    redirect_to homepage_path if search_params.nil? || search_params.empty?

    @q = search_params

    @posts_searched = Post.containing(@q)

    @posts = @posts_searched.any? ? @posts_searched : Post.all
  end

  def vote
    # =====> Hello, Interviewers!
    #
    # this endpoint gets hit by a Stimulus controller
    # it decides how to in/decrement the @post's vote count
    # and saves a record of the vote state into the session cookie
    # it's a light-weight imitation of SO functionality
    # and gives the user some persistent state history
    # about votes and bookmarks.
    #
    # In true Rails 7 style, I'm returning an HTML slug
    set_vote_directions

    # already voted in this direction
    if helpers.session_has_record(@post.id, @direction, 'posts')
      remove_session_record(@post.id, @direction, 'posts')
      @post.update(votes: @post.votes - @vote_change)
    else
      # already voted in opposite direction
      if helpers.session_has_record(@post.id, @opposite, 'posts')
        remove_session_record(@post.id, @opposite, 'posts')
        @vote_change *= 2
      end

      add_session_record(@post.id, @direction, 'posts')
      @post.update(votes: @post.votes + @vote_change)
    end

    @post.reload

    render 'vote_buttons', layout: false
  end

  def bookmark
    if helpers.session_has_record(@post.id, 'bookmarked', 'posts')
      remove_session_record(@post.id, 'bookmarked', 'posts')
    else
      add_session_record(@post.id, 'bookmarked', 'posts')
    end

    @post.reload

    render 'vote_buttons', layout: false
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :accepted, :question_id, tag_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def search_params
    params[:q]
  end

  def question_params
    params[:question]
  end

  def set_vote_directions
    @direction = params[:d]
    @opposite = (%w[downvoted upvoted] - [@direction])[0]

    @vote_change = Constants::VOTE_CHANGE[@direction]
  end
end
