class ItemListsController < ApplicationController
  def index
    @item_lists = current_user.item_lists.includes(:user).order(created_at: :asc)
  end

  def show
    @item_list = ItemList.find(params[:id])
    @selected_original_items = @item_list.original_items.where(selected: true)
  end

  def new
    @item_list = ItemList.new
  end

  def create
    @item_list = current_user.item_lists.build(item_list_params)
    if @item_list.save
      redirect_to item_lists_path
    else
      redirect_to item_lists_path
    end
  end

  def edit
    @item_list = current_user.item_lists.find(params[:id])
  end

  def update
    @item_list = ItemList.find(params[:id])
  
    if params[:item_list].present? && params[:item_list][:original_item_ids].present?
      @item_list.original_items.update_all(selected: false)
  
      selected_ids = params[:item_list][:original_item_ids]
      OriginalItem.where(id: selected_ids).update_all(selected: true)
  
      @item_list.original_items = OriginalItem.where(id: selected_ids)
    else
      @item_list.original_items.update_all(selected: false)
    end
  
    redirect_to item_list_path(@item_list)
  end

  def destroy
    item_list = current_user.item_lists.find(params[:id])
    item_list.destroy!
    redirect_to item_lists_path, notice: t("defaults.flash_message.deleted", item: ItemList.model_name.human), status: :see_other
  end

  private

  def item_list_params
    params.require(:item_list).permit(:name, original_item_ids: [])
  end
end
