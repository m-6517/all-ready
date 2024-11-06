class ItemListsController < ApplicationController
  def index
    @item_lists = current_user.item_lists.includes(:user).order(created_at: :asc)
  end

  def show
    @item_list = ItemList.find(params[:id])
    @selected_original_items = @item_list.original_items.where(selected: true)
    @selected_default_items = @item_list.default_items.where(selected: true)
    @item_statuses = @item_list.item_statuses.includes(:original_item, :default_item)
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

    if @item_list.update(item_list_params)
      if params[:item_list][:original_item_ids].present?
        selected_original_ids = params[:item_list][:original_item_ids].map(&:to_i)
        @item_list.original_items.each do |item|
          item.update(selected: selected_original_ids.include?(item.id))
          ItemStatus.find_or_create_by(item_list_id: @item_list.id, original_item_id: item.id) do |status|
            status.is_checked = false
          end
        end
      end

      if params[:item_list][:default_item_ids].present?
        selected_default_ids = params[:item_list][:default_item_ids].map(&:to_i)
        @item_list.default_items.each do |item|
          item.update(selected: selected_default_ids.include?(item.id))
          ItemStatus.find_or_create_by(item_list_id: @item_list.id, default_item_id: item.id) do |status|
            status.is_checked = false
          end
        end
      end
    end

    redirect_to item_list_path(@item_list)
  end

  def destroy
    item_list = current_user.item_lists.find(params[:id])

    item_list.original_items.update_all(item_list_id: nil)

    item_list.destroy!
    redirect_to item_lists_path, notice: t("defaults.flash_message.deleted", item: ItemList.model_name.human), status: :see_other
  end

  private

  def item_list_params
    params.require(:item_list).permit(:name, original_item_ids: [], default_item_ids: [])
  end
end
