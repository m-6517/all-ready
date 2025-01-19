class BookmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  def index
    @bookmarked_recommends = current_user.bookmarks.includes(:bookmarkable).map(&:bookmarkable)
    @bookmarked_bag_contents = current_user.bookmarks.includes(:bookmarkable).map(&:bookmarkable)
  end

  def create
    unless user_signed_in?
      flash[:alert] = t("defaults.flash_message.require_login")
      redirect_to request.referer and return
    end

    bookmarkable_uuid = params[:bookmarkable]
    @recommend = Recommend.find_by(uuid: bookmarkable_uuid)
    @bag_content = BagContent.find_by(uuid: bookmarkable_uuid)
    @bookmarkable = @recommend || @bag_content
    current_user.bookmark(@bookmarkable)
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    if bookmark.bookmarkable_type == "Recommend"
      @recommend = bookmark.bookmarkable
      @bag_content = nil
    else bookmark.bookmarkable_type == "BagContent"
      @bag_content = bookmark.bookmarkable
      @recommend = nil
    end
    current_user.unbookmark(@recommend || @bag_content)
  end
end
