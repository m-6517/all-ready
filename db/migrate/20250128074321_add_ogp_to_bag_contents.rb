class AddOgpToBagContents < ActiveRecord::Migration[7.2]
  def change
    add_column :bag_contents, :ogp, :string
  end
end
