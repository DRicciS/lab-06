class CreateChats < ActiveRecord::Migration[7.1] # Adjust class name/version
  def change
    create_table :chats do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
# If modifying an existing table, use add_reference inside the change method.