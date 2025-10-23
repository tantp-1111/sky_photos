class EmoReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.emo_count += 1
    @post.save
    redirect_to post_path(@post)
  end
end
