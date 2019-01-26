class RemoveUserAndAddNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
