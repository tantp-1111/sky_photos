class BookmarksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.bookmark(@post)
    redirect_to post_path(params[:post_id]), success: t('.success')
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    post = bookmark.post
    current_user.unbookmark(post)
    redirect_to post_path(post), success: t('.success'), status: :see_other
  end
end