# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tab_params = tab_params
    @tags =
      case @tab_params
      when 'popular'
        Tag.ordered_by_score
      else
        Tag.ordered_by_name
      end
  end

  def search
    @tag = Tag.where(name: params[:tag_name]).first

    @questions = @tag.posts
  end

  ## =====> Hello, Interviewers!
  # Fully fledged TurboStream element here.
  # Realtime search on TagsController#index
  # SEE views/tags/index.haml:13
  # SEE views/tags/index.haml:23
  # SEE views/tags/live_search.turbo_stream.erb
  def live_search
    @tags = Tag.matching_search(tags_search_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def tab_params
    params.permit(:tab)['tab']
  end

  def tags_search_params
    params.permit(:name_search)[:name_search]
  end
end
