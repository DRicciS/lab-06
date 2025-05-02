class AddIndexToUsersEmail < ActiveRecord::Migration[7.1] # Adjust version if needed
  def change
    # Add a unique index to the email column for database-level uniqueness
    # and faster lookups.
    add_index :users, :email, unique: true unless index_exists?(:users, :email, unique: true)
  end
end