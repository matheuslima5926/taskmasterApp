class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
