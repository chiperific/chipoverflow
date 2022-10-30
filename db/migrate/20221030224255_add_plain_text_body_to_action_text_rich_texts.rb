# frozen_string_literal: true

class AddPlainTextBodyToActionTextRichTexts < ActiveRecord::Migration[7.0]
  def up
    add_column :action_text_rich_texts, :plain_text_body, :text
    add_index :action_text_rich_texts, "to_tsvector('english', plain_text_body)", using: :gin, name: 'tsvector_body_idx'

    ActionText::RichText.all.each(&:save)
  end

  def down
    remove_index :action_text_rich_texts, name: 'tsvector_body_idx'
    remove_column :action_text_rich_texts, :plain_text_body
  end
end
