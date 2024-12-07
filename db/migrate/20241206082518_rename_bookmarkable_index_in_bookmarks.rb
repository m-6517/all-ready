class RenameBookmarkableIndexInBookmarks < ActiveRecord::Migration[7.2]
  def up
    rename_column :bookmarks, :reference_type, :bookmarkable_type
    rename_column :bookmarks, :reference_id, :bookmarkable_id

    remove_index :bookmarks, name: "index_bookmarks_on_reference"
    add_index :bookmarks, [ :bookmarkable_type, :bookmarkable_id ], name: "index_bookmarks_on_bookmarkable"
  end

  def down
    remove_index :bookmarks, name: "index_bookmarks_on_bookmarkable"

    if column_exists?(:bookmarks, :bookmarkable_type) && column_exists?(:bookmarks, :bookmarkable_id)
      rename_column :bookmarks, :bookmarkable_type, :reference_type
      rename_column :bookmarks, :bookmarkable_id, :reference_id
    end

    if column_exists?(:bookmarks, :reference_type) && column_exists?(:bookmarks, :reference_id)
      add_index :bookmarks, [ :reference_type, :reference_id ], name: "index_bookmarks_on_reference"
    end
  end
end
