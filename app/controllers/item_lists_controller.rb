class ItemListsController < ApplicationController
  def index
    @item_lists = ItemList.includes(:user)
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
      redirect_to item_lists_path, notice: t("defaults.flash_message.created", item: ItemList.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: ItemList.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_list_params
    params.require(:item_list).permit(:name)
  end
end
