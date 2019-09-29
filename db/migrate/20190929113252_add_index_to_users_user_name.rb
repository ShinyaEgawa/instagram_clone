class AddIndexToUsersUserName < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :user_name, unique: true
  end
end
