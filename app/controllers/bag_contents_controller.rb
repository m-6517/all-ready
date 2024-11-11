class BagContentsController < ApplicationController
  def index
    @bag_contents = current_user.bag_contents.includes(:user).order(created_at: :desc)
  end

  def new
    @bag_content = current_user.bag_contents.new
  end

  def create
    @item_list = ItemList.find(params[:item_list_id])

    if current_user.bag_contents.exists?(item_list_id: @item_list.id)
      redirect_to item_list_path(@item_list), alert: "この持ち物リストは既に共有されています"
    else
      @bag_content = current_user.bag_contents.new(bag_content_params.merge(item_list: @item_list))

      if @bag_content.save
        redirect_to item_list_bag_contents_path(@item_list), notice: "持ち物リストを共有しました"
      else
        render :new, alert: "持ち物リストを共有できませんでした"
      end
    end
  end

  private

  def bag_content_params
    params.require(:bag_content).permit(:item_list_id, :body)
  end
end
