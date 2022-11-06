# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :author, null: false, foreign_key: true
      t.string :title
      t.string :title_slug, default: '', null: false
      t.text :body
      t.integer :votes, default: 0, null: false, index: true
      t.integer :views, default: 0, null: false
      t.boolean :accepted, null: false, default: false
      t.references :question, foreign_key: { to_table: :posts }
      t.integer :rank, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
