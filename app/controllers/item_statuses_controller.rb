class ItemStatusesController < ApplicationController
  include ActionView::RecordIdentifier

  def toggle
    @item_status = ItemStatus.find(params[:id])

    @item_status.update(is_checked: !@item_status.is_checked)
    @item_status.update(selected: !@item_status.selected)

    render turbo_stream: turbo_stream.replace(dom_id(@item_status), partial: "item_statuses/item_status", locals: { item_status: @item_status })
  end
end
