class ItemStatusesController < ApplicationController
  include ActionView::RecordIdentifier

  def toggle
    @item_status = ItemStatus.find(params[:id])

    @item_status.update(is_checked: !@item_status.is_checked)

    @item_list = @item_status.item_list
    @item_list.update_ready_status

    render turbo_stream: [
      turbo_stream.replace(dom_id(@item_status), partial: "item_statuses/item_status", locals: { item_status: @item_status }),
      turbo_stream.replace(dom_id(@item_list, :ready_status), partial: "item_lists/ready_status", locals: { item_list: @item_list })
    ]
  end
end
