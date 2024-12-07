class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks, id: :uuid do |t|
      t.references :reference, polymorphic: true, null: false, type: :uuid
      t.timestamps
    end

    add_index :bookmarks, [:reference_type, :reference_id]
  end
end
