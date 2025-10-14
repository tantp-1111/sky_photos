class BookmarksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.bookmark(@post)

  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    @post = bookmark.post
    current_user.unbookmark(@post)

  end
end
