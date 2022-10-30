# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params)

    if @post.save
      redirect_to homepage_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to homepage_path
    else
      render :edit
    end
  end

  def show
    @post.update_column(views: @post.views++)
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
    params.require(:post).permit(:title, :body, tag_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def search_params
    params[:q]
  end
end
