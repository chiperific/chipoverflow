# frozen_string_literal: true

class AddPublishedAtToPostsAndComments < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published_at, :datetime, index: true
    add_column :comments, :published_at, :datetime, index: true
  end
end
