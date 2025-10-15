class CommentsController < ApplicationController
  before_action :set_comment, only: [ :edit, :update, :destroy, :show ]

  def create
    @comment = current_user.comments.build(comment_create_params)
    @comment.save
  end

  def edit; end

  def show; end

  def update
    @comment.update(comment_update_params)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_create_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
