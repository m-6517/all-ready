class AddUserToBookmarks < ActiveRecord::Migration[7.2]
  def change
    add_column :bookmarks, :user_uuid, :uuid
    change_column_null :bookmarks, :user_uuid, false
    add_foreign_key :bookmarks, :users, column: :user_uuid, primary_key: :uuid
    add_index :bookmarks, :user_uuid
  end
end
