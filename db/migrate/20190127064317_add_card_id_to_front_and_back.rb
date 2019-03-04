# frozen_string_literal: true

class AddCardIdToFrontAndBack < ActiveRecord::Migration[5.2]
  def change
    add_column :fronts, :card_id, :integer
    add_column :backs, :card_id, :integer
  end
end
