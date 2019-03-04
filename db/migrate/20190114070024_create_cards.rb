# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.text :front
      t.text :back
      t.integer :deck_id
      t.integer :interval, default: 1
      t.integer :ease, default: 250
      t.integer :status
      t.date :day_to_study

      t.timestamps
    end
  end
end
