# frozen_string_literal: true

##
# Join table model only for custom seed_dump rake task
class PostsTag < ApplicationRecord
  def for_seed
    { post_id: post_id, tag_id: tag_id }
  end
end
