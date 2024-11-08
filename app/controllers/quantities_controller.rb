class QuantitiesController < ApplicationController
  before_action :set_item_list

  def index
    @item_statuses = @item_list.item_statuses.where(selected: true)
  end

  def edit
    @item_statuses = @item_list.item_statuses.where(selected: true)
  end

  def update
    item_status = ItemStatus.find(params[:id])
    item_status.update(quantity: params[:item_status][:quantity])
    redirect_to item_list_path(@item_list)
  end

  private

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end
end