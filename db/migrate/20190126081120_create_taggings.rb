# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer 'tag_id'
      t.integer 'card_id'
      t.timestamps
    end
  end
end
