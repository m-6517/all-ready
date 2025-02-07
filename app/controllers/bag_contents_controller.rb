class BagContentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  helper_method :prepare_meta_tags

  def index
    bag_contents = BagContent.all
    @search_form = SearchForm.new(search_params)
    @bag_contents = @search_form.search(bag_contents).order(created_at: :desc)
  end

  def show
    @bag_content = BagContent.find_by(uuid: params[:id])
    @item_list = @bag_content.item_list

    bag_contents = if (tag_name = params[:tag_name])
      bag_contents.with_tag(tag_name)
    else
      bag_contents
    end

    prepare_meta_tags(@bag_content)
  end

  def new
    @bag_content = BagContent.new
  end

  def create
    @item_list = ItemList.find(params[:item_list_id])
    @bag_content = current_user.bag_contents.new(item_list_id: @item_list.id)
    tag_names = params[:tag_name]

    if @item_list.original_items.empty? && @item_list.default_items.empty?
      flash[:alert] = t("defaults.flash_message.empty_list", item: BagContent.model_name.human)
      redirect_to item_list_path(@item_list)
    else
      if @bag_content.save
        if tag_names.present?
          tags = tag_names.split(" ").map(&:strip).uniq
          create_or_update_bag_content_tags(@bag_content, tags)
        end
        redirect_to bag_content_path(@bag_content), notice: t("defaults.flash_message.shared", item: BagContent.model_name.human)
      else
        render :new, alert: t("defaults.flash_message.not_shared", item: BagContent.model_name.human)
      end
    end
  end

  def edit
    @bag_content = current_user.bag_contents.find_by(uuid: params[:id])
  end

  def update
    @bag_content = current_user.bag_contents.find_by(uuid: params[:id])
    @bag_content.body = bag_content_params[:body]
    tag_names = params[:bag_content][:tag_names]

    if @bag_content.update(bag_content_params)
      if tag_names.present?
        tags = params[:bag_content][:tag_names].split(" ").map(&:strip).uniq
        create_or_update_bag_content_tags(@bag_content, tags)
      end
      redirect_to bag_content_path(@bag_content), notice: t("defaults.flash_message.updated", item: BagContent.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: BagContent.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    bag_content = current_user.bag_contents.find_by(uuid: params[:id])
    bag_content.destroy!
    redirect_to bag_contents_path, notice: t("defaults.flash_message.deleted", item: BagContent.model_name.human), status: :see_other
  end

  private

  def create_or_update_bag_content_tags(bag_content, tags)
    bag_content.tags.destroy_all
    begin
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      bag_content.tags << tag
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
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
    params.require(:bag_content).permit(:item_list_id, :body)
  end
end
