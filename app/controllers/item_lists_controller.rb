class ItemListsController < ApplicationController
  include ActionView::RecordIdentifier

  def index
    @item_lists = ItemList.where(user_uuid: current_user.uuid).includes(:user).order(created_at: :asc)
    @bag_contents = BagContent.all
  end

  def show
    @item_list = ItemList.find(params[:id])

    @default_items = DefaultItem.includes(:item_statuses).all
    @original_items = OriginalItem.includes(:item_statuses).all

    @selected_default_items = @default_items.select do |item|
      item.item_statuses.find_by(item_list_id: @item_list.id)&.selected
    end.sort_by do |item|
      item.item_statuses.find_by(item_list_id: @item_list.id)&.position || 0
    end

    @selected_original_items = @original_items.select do |item|
      item.item_statuses.find_by(item_list_id: @item_list.id)&.selected
    end.sort_by do |item|
      item.item_statuses.find_by(item_list_id: @item_list.id)&.position || 0
    end
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
    @item_list = current_user.item_lists.find_by(uuid: params[:id])
  end

  def update
    @item_list = ItemList.find(params[:id])

    if @item_list.update(item_list_params)
      if params[:item_list][:original_item_ids].present? || params[:item_list][:default_item_ids].present?
        @item_list.item_statuses.update_all(selected: false)

        if params[:item_list][:original_item_ids].present?
          selected_original_ids = params[:item_list][:original_item_ids].map(&:to_i)
          @item_list.original_items.each do |item|
            item_status = ItemStatus.find_or_create_by(item_list_id: @item_list.id, original_item_id: item.id)
            item_status.update(selected: selected_original_ids.include?(item.id))
          end
        end

        if params[:item_list][:default_item_ids].present?
          selected_default_ids = params[:item_list][:default_item_ids].map(&:to_i)
          @item_list.default_items.each do |item|
            item_status = ItemStatus.find_or_create_by(item_list_id: @item_list.id, default_item_id: item.id)
            item_status.update(selected: selected_default_ids.include?(item.id))
          end
        end
        # チェックボックスの変更
        redirect_to item_list_path(@item_list), notice: t("defaults.flash_message.updated", item: ItemList.model_name.human)
      else
        # リスト名、カバー画像などの変更
        redirect_to item_lists_path, notice: t("defaults.flash_message.updated", item: ItemList.model_name.human)
      end
    end
  end

  def destroy
    item_list = ItemList.find_by(user_uuid: current_user.uuid, id: params[:id])
    ItemListOriginalItem.where(item_list_id: item_list.id).destroy_all
    item_list.destroy!
    redirect_to item_lists_path, notice: t("defaults.flash_message.deleted", item: ItemList.model_name.human), status: :see_other
  end

  def duplicate
    @item_list = ItemList.find(params[:id])
    duplicated_item_list = @item_list.duplicate
    redirect_to item_lists_path
  end

  def clear_checked_items
    @item_list = ItemList.find(params[:id])
    @item_list.clear_checked_items
    @item_statuses = @item_list.item_statuses
    redirect_to item_list_path(@item_list)
  end

  def update_position
    @item_list = ItemList.find(params[:id])
    if params[:item_ids].present?
      @item_list.update_position(params[:item_ids])
      head :ok
    end
  end

  private

  def set_item_list
    @item_list = ItemList.find(params[:id])
  end

  def item_list_params
    params.require(:item_list).permit(:name, :cover_image, :cover_image_cache, original_item_ids: [], default_item_ids: [])
  end
end
