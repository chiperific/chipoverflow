# frozen_string_literal: true

class CreateChips < ActiveRecord::Migration[7.0]
  def up
    create_table :chips do |t|
      t.string  :name, default: 'Chip Kragt'
      t.string  :phone, default: '616.528.8140'
      t.string  :address, default: '1001 Alexander St SE, Grand Rapids, MI 49507'
      t.string  :gravatar_url, default: 'https://www.gravatar.com/avatar/5c7a5fcd85529e17f9aa86c1e9a5490e?s=48&d=identicon&r=PG', null: false
      t.integer :so_id, default: 1_880_203, null: false
      t.integer :reputation
      t.integer :gold
      t.integer :silver
      t.integer :bronze
      t.datetime :reputation_updated_at
    end

    Chip.new.save
  end

  def down
    drop_table :chips
  end
end
