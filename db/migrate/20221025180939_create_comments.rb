# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :author, null: false, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
      t.text :body
      t.integer :rank, null: false, default: Time.now.to_i

      t.timestamps
    end
  end
end
