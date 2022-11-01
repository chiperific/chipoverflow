# frozen_string_literal: true

class TagsController < ApplicationController
  def search
    @tag = Tag.where(name: params[:tag_name]).first

    @questions = @tag.posts
  end
end
