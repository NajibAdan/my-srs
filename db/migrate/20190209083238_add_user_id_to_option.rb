class AddUserIdToOption < ActiveRecord::Migration[5.2]
  def change
    add_column :options, :user_id, :integer
  end
end
