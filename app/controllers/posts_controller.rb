# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update]
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

  def show; end

  private

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
