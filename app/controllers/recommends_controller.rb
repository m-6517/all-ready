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
end
