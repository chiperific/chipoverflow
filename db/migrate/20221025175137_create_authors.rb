# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :reputation, default: 0, null: false
      t.integer :gold, default: 0, null: false
      t.integer :silver, default: 0, null: false
      t.integer :bronze, default: 0, null: false
      t.string :gravatar_url
    end
  end
end
