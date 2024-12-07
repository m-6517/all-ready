class RenameBookmarkableIndexInBookmarks < ActiveRecord::Migration[7.2]
  def change
    rename_column :bookmarks, :reference_type, :bookmarkable_type
    rename_column :bookmarks, :reference_id, :bookmarkable_id

    remove_index :bookmarks, name: "index_bookmarks_on_reference"

    add_index :bookmarks, [:bookmarkable_type, :bookmarkable_id], name: "index_bookmarks_on_bookmarkable"
  end
end
