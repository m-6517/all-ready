class ItemListsController < ApplicationController
  def index
    @item_lists = ItemList.includes(:user)
  end
end
