class RemoveDuplicateIndexFromBookmarks < ActiveRecord::Migration[7.2]
  def change
    if index_exists?(:bookmarks, [ :bookmarkable_type, :bookmarkable_id ], name: "index_bookmarks_on_bookmarkable_type_and_bookmarkable_id")
      remove_index :bookmarks, name: "index_bookmarks_on_bookmarkable_type_and_bookmarkable_id"
    end
  end
end
