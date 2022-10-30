# frozen_string_literal: true

class CreateChips < ActiveRecord::Migration[7.0]
  def change
    create_table :chips do |t|
      t.string  :name
      t.string  :phone
      t.string  :address
      t.string  :gravatar_url
      t.integer :so_id, default: 0, null: false
      t.integer :reputation, default: 0, null: false
      t.integer :gold, default: 0, null: false
      t.integer :silver, default: 0, null: false
      t.integer :bronze, default: 0, null: false
      t.datetime :reputation_updated_at
    end
  end
end
