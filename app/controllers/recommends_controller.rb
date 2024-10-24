class RecommendsController < ApplicationController
  def index
    @recommends = Recommend.includes(:user).all.group_by(&:place)
  end

  def by_place
    @place = params[:place]
    @recommends = Recommend.includes(:user).where(place: @place)
  end

  def show
    @recommend = Recommend.includes(:user).find(params[:id])
  end

  def new
    @recommend = Recommend.new
  end

  def create
    @recommend = current_user.recommends.build(recommend_params)
    if @recommend.save
      redirect_to recommends_path, notice: t("defaults.flash_message.created", item: Recommend.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Recommend.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recommend_params
    params.require(:recommend).permit(:place, :item, :body)
  end
end
