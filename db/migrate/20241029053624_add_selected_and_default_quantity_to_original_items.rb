class AddSelectedAndDefaultQuantityToOriginalItems < ActiveRecord::Migration[7.2]
  def change
    add_column :original_items, :selected, :boolean, default: :false, null: false
    change_column_default :original_items, :quantity, from: nil, to: 1
  end
end
