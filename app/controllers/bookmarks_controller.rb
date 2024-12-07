class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_recommends = current_user.bookmarks.includes(:bookmarkable).map(&:bookmarkable)
  end

  def create
    bookmarkable_uuid = params[:bookmarkable]
    @recommend = Recommend.find_by(uuid: bookmarkable_uuid)
    current_user.bookmark(@recommend)
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    @recommend = bookmark.bookmarkable
    current_user.unbookmark(@recommend)
  end
end
