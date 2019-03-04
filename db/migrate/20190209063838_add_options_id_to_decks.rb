# frozen_string_literal: true

class AddOptionsIdToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :option_id, :integer
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
