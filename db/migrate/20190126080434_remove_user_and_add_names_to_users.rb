# frozen_string_literal: true

class RemoveUserAndAddNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username
    add_column :users, :name, :string
  end
end
