class ItemsController < ApplicationController
  before_action :set_item_list, only: %i[new create update]

  def new
    @original_items = OriginalItem.where(user_uuid: current_user.uuid).order(created_at: :asc)
    @default_items = DefaultItem.all
    @new_original_item = OriginalItem.new
    @item_status = ItemStatus.new
  end

  def create
    @item_list = ItemList.find(params[:item_list_id])
    max_position = @item_list.item_statuses.maximum(:position).to_i
    new_original_item = OriginalItem.new(original_item_params.merge(user: current_user))

    if new_original_item.save
      item_list_original_item = ItemListOriginalItem.find_or_create_by(item_list: @item_list, original_item: new_original_item)
      item_status = ItemStatus.create(item_list: @item_list, original_item: new_original_item, position: max_position + 1, is_checked: false, selected: false, quantity: 1)
      redirect_to new_item_list_item_path(@item_list)
    else
      render :new
    end
  end

  def update
    if params[:original_item_ids].present?
      @item_list.original_items.update_all(selected: false)

      selected_original_ids = params[:original_item_ids]
      OriginalItem.where(id: selected_original_ids).update_all(selected: true)

      selected_original_ids.each do |original_item_id|
        ItemListOriginalItem.find_or_create_by(item_list: @item_list, original_item_id: original_item_id)
      end
    else
      @item_list.original_items.update_all(selected: false)
    end

    if params[:default_item_ids].present?
      @item_list.default_items.update_all(selected: false)
      selected_default_ids = params[:default_item_ids]
      DefaultItem.where(id: selected_default_ids).update_all(selected: true)
    else
      @item_list.default_items.update_all(selected: false)
    end

    redirect_to item_list_path(@item_list)
  end

  def destroy_original_item
    item_list = ItemList.find(params[:item_list_id])
    original_item = OriginalItem.find(params[:id])

    item_list_original_item = ItemListOriginalItem.find_by(item_list: item_list, original_item: original_item)

    item_list_original_item.destroy

    redirect_to new_item_list_item_path(item_list), status: :see_other
  end

  private

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end

  def original_item_params
    params.require(:original_item).permit(:name, :position, :quantity)
  end
end
