# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[edit update vote flag]

  def new
    @comment = Comment.new
  end

  def create
    if @post.comments.create(comment_params)
      redirect_to_question(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to_question(@post)
    else
      render :edit
    end
  end

  def vote
    # already upvoted
    if helpers.session_has_record(@comment.id, 'upvoted', 'comments')
      remove_session_record(@comment.id, 'upvoted', 'comments')
      @comment.update(rank: (@comment.rank / 1.8).to_i)
    else
      add_session_record(@comment.id, 'upvoted', 'comments')
      @comment.update(rank: (@comment.rank * 1.8).to_i)
    end

    @comment.reload

    render 'vote_button', layout: false
  end

  def flag
    # already flagged
    if helpers.session_has_record(@comment.id, 'flagged', 'comments')
      remove_session_record(@comment.id, 'flagged', 'comments')
    else
      add_session_record(@comment.id, 'flagged', 'comments')
    end

    render 'flag_button', layout: false
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
