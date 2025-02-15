class RecommendsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index by_place show]
  helper_method :prepare_meta_tags

  def index
    @recommends = Recommend.order(created_at: :desc).group_by(&:place)
  end

  def by_place
    @place = params[:place]
    @recommends = Recommend.where(place: @place)
  end

  def show
    @recommend = Recommend.find_by(uuid: params[:id])
    prepare_meta_tags(@recommend)
  end

  def new
    @recommend = Recommend.new
  end

  def create
    @recommend = current_user.recommends.build(recommend_params)
    if @recommend.save
      redirect_to recommend_path(@recommend), notice: t("defaults.flash_message.created", item: Recommend.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Recommend.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recommend = current_user.recommends.find_by(uuid: params[:id])
  end

  def update
    @recommend = current_user.recommends.find_by(uuid: params[:id])
    if @recommend.update(recommend_params)
      redirect_to recommend_path(@recommend), notice: t("defaults.flash_message.updated", item: Recommend.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Recommend.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    recommend = current_user.recommends.find_by(uuid: params[:id])
    recommend.destroy!
    redirect_to recommends_path, notice: t("defaults.flash_message.deleted", item: Recommend.model_name.human), status: :see_other
  end

  private

  def prepare_meta_tags(recommend)
    image_url = OgpCreator.build(recommend.item, recommend.place, recommend.user.name, recommend: recommend)

    set_meta_tags og: {
                    site_name: "All Ready",
                    title: "#{recommend.item} | All Ready",
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

  def recommend_params
    params.require(:recommend).permit(:place, :item, :body, :item_image, :item_image_cache)
  end
end
