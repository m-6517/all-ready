class BagContentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_item_list, only: %i[ show new create ]
  helper_method :prepare_meta_tags

  def index
    bag_contents = BagContent.all

    bag_contents = if (tag_name = params[:tag_name])
      bag_contents.with_tag(tag_name)
    else
      bag_contents
    end

    @search_form = SearchForm.new(search_params)
    @bag_contents = @search_form.search(bag_contents).order(created_at: :desc)
  end

  def show
    @bag_content = BagContent.find_by(uuid: params[:id])
    prepare_meta_tags(@bag_content)
  end

  def new
    @bag_content = current_user.bag_contents.new
  end

  def create
    @bag_content = @item_list.bag_contents.find_by(user: current_user)

    if @item_list.original_items.empty? && @item_list.default_items.empty?
      redirect_to item_list_path(@item_list), alert: "空の持ち物リストは共有できません"
      return
    end

    if @bag_content.nil?
      @bag_content = BagContent.new(bag_content_params)
    end

    if current_user.bag_contents.exists?(item_list_id: @item_list.id)
      redirect_to item_list_path(@item_list), alert: "この持ち物リストは既に共有されています"
    else
      @bag_content = current_user.bag_contents.new(bag_content_params.merge(item_list: @item_list))

      if @bag_content.save_with_tags(tag_name: params.dig(:bag_content, :tag_name).split(",").uniq)
        redirect_to item_list_bag_contents_path(@item_list), notice: "持ち物リストを共有しました"
      else
        render :new, alert: "持ち物リストを共有できませんでした"
      end
    end
  end

  def edit
    @bag_content = current_user.bag_contents.find_by(uuid: params[:id])
  end

  def update
    @bag_content = current_user.bag_contents.find_by(uuid: params[:id])
    @bag_content.body = bag_content_params[:body]

    if @bag_content.save_with_tags(tag_name: params.dig(:bag_content, :tag_name).split(",").uniq)
      redirect_to bag_contents_path(@bag_content), notice: "投稿を更新しました"
    else
      flash.now[:alert] = "投稿を更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    bag_content = current_user.bag_contents.find_by(uuid: params[:id])
    bag_content.destroy!
    redirect_to bag_contents_path, notice: t("defaults.flash_message.deleted", item: BagContent.model_name.human), status: :see_other
  end

  private

  def set_item_list
    @item_list = ItemList.find(params[:item_list_id])
  end

  def search_params
    params.fetch(:q, {}).permit(:search_term)
  end

  def prepare_meta_tags(bag_content)
    image_url = OgpCreator.build(bag_content.item_list.name, bag_content.user.name, "", bag_content: bag_content)

    set_meta_tags og: {
                    site_name: "All Ready",
                    title: "#{bag_content.item_list.name} | All Ready",
                    type: "website",
                    url: request.original_url,
                    image: image_url,
                    locale: "ja-JP"
                  },
                  twitter: {
                    card: "summary_large_image",
                    site: "@kumateq",
                    image: image_url
                  }
  end

  def bag_content_params
    params.require(:bag_content).permit(:item_list_id, :body, tag_ids: [])
  end
end
