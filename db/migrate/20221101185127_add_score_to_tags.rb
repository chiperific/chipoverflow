# frozen_string_literal: true

class AddScoreToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :score, :integer, index: true, default: 0, null: false
  end
end
