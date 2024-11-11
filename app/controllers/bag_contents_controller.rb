class BagContentsController < ApplicationController
  before_action :set_item_list, only: %i[ show new create ]

  def index
    @bag_contents = BagContent.includes(:user).order(created_at: :desc)
  end

  def show
    @bag_content = BagContent.find_by(id: params[:id])
  end

  def new
    @bag_content = current_user.bag_contents.new
  end

  def create
    @item_list = ItemList.find(params[:item_list_id])
    @bag_content = @item_list.bag_contents.find_by(user: current_user)

    if @bag_content.nil?
      @bag_content = BagContent.new(bag_content_params)
    end

    if current_user.bag_contents.exists?(item_list_id: @item_list.id)
      redirect_to item_list_path(@item_list), alert: "この持ち物リストは既に共有されています"
    else
      @bag_content = current_user.bag_contents.new(bag_content_params.merge(item_list: @item_list))

      if @bag_content.save
        redirect_to item_list_bag_contents_path(@item_list), notice: "かばんの中身を共有しました"
      else
        render :new, alert: "かばんの中身を共有できませんでした"
      end
    end
  end

  def edit
    @bag_content = current_user.bag_contents.find(params[:id])
  end

  def update
    @bag_content = current_user.bag_contents.find(params[:id])
    if @bag_content.update(bag_content_params)
      redirect_to bag_contents_path(@bag_content), notice: "かばんの中身を更新しました"
    else
      flash.now[:alert] = "かばんの中身を更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    bag_content = current_user.bag_contents.find(params[:id])
    bag_content.destroy!
    redirect_to bag_contents_path, notice: t("defaults.flash_message.deleted", item: BagContent.model_name.human), status: :see_other
  end

  private

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end

  def bag_content_params
    params.require(:bag_content).permit(:item_list_id, :body)
  end
end
