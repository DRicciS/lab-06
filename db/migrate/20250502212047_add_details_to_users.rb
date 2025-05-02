class AddDetailsToUsers < ActiveRecord::Migration[7.1] # Adjust version if needed
  def change
    add_column :users, :first_name, :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string unless column_exists?(:users, :last_name)
    add_column :users, :email, :string unless column_exists?(:users, :email)
  end
end