class UpdateUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :name, false
  end
end
