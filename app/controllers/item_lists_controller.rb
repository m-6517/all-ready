class ItemListsController < ApplicationController
  def index
    @item_lists = current_user.item_lists.includes(:user).order(created_at: :asc)
  end

  def show
    @item_list = ItemList.find(params[:id])
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
    @item_list = current_user.item_lists.find(params[:id])

    if @item_list.update(item_list_params)
      redirect_to item_lists_path
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: ItemList.model_name.human)
      redirect_to item_lists_path
    end
  end

  def destroy
    item_list = current_user.item_lists.find(params[:id])
    item_list.destroy!
    redirect_to item_lists_path, notice: t("defaults.flash_message.deleted", item: ItemList.model_name.human), status: :see_other
  end

  private

  def item_list_params
    params.require(:item_list).permit(:name)
  end
end
