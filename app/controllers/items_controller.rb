class ItemsController < ApplicationController
  before_action :set_item_list, only: %i[new create update]

  def new
    @original_items = OriginalItem.where(user_id: current_user.id).order(created_at: :asc)
    @new_original_item = OriginalItem.new
  end

  def create
    if params[:original_item].present?
      new_original_item = OriginalItem.new(original_item_params)
      new_original_item.user = current_user
      new_original_item.item_list_id = @item_list.id

      if new_original_item.save
        @item_list.original_items << new_original_item
        redirect_to new_item_list_item_path(@item_list)
      else
        render :new
      end
    end
  end

  def update
    if params[:original_item_ids].present?
      @item_list.original_items.update_all(selected: false)
  
      selected_ids = params[:original_item_ids]
      OriginalItem.where(id: selected_ids).update_all(selected: true)
  
      @item_list.original_items = OriginalItem.where(id: selected_ids)
    else
      @item_list.original_items.update_all(selected: false)
    end
  
    redirect_to item_list_path(@item_list)
  end
  
  private

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end

  def original_item_params
    params.require(:original_item).permit(:name, :position, :quantity)
  end
end
