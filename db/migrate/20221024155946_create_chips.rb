# frozen_string_literal: true

class CreateChips < ActiveRecord::Migration[7.0]
  def change
    create_table :chips do |t|
      t.string  :name
      t.string  :phone
      t.string  :address
      t.string  :gravatar_url
      t.integer :so_id
      t.integer :reputation
      t.integer :gold
      t.integer :silver
      t.integer :bronze
      t.datetime :reputation_updated_at
    end
  end
end
