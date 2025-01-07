class ItemStatusesController < ApplicationController
  before_action :set_item_status
  include ActionView::RecordIdentifier

  def toggle
    @item_status.update(is_checked: !@item_status.is_checked)

    @item_list = @item_status.item_list
    @item_list.update_ready_status

    render turbo_stream: [
      turbo_stream.replace(dom_id(@item_status), partial: "item_statuses/item_status", locals: { item_status: @item_status }),
      turbo_stream.replace(dom_id(@item_list, :ready_status), partial: "item_lists/ready_status", locals: { item_list: @item_list })
    ]
  end

  def sort
    ids = params[:ids]
    ids.each_with_index do |id, index|
      item_status = ItemStatus.find(id)
      item_status.update(position: index + 1)
    end

    head :ok
  end

  private

  def set_item_status
    @item_status = ItemStatus.find(params[:id])
  end
end
