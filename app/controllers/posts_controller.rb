# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]
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

  def edit; end

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

    # debugger
    console
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :question_id, tag_ids: [])
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
end
