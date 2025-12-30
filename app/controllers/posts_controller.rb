class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    # ページネーションpost16個まで表示
    @posts = Post.includes(:user, image_attachment: :blob)
      .order(created_at: :desc)
      .page(params[:page])
      .per(16)
    # 現在のユーザーがどの投稿をお気に入り（bookmark）しているかをまとめて取得
    if current_user
      @user_bookmarked_post_ids = current_user.bookmarks.where(post_id: @posts.pluck(:id)).pluck(:post_id)
    else
      @user_bookmarked_post_ids = []
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: t("defaults.flash_message.updated", item: Post.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
  end

  def bookmarks
    @bookmark_posts = current_user.bookmark_posts
    # bookmarkのpost_idを配列に入れる。この変数を_post.html.erbで使用するため定義
    @user_bookmarked_post_ids = @bookmark_posts.pluck(:id)
  end

  # エモカウンター
  def emo_reactions
    @post = Post.find(params[:id])
    @post.emo_count += 1

    if @post.save
      # emo_reactions.turbo_stream.erb呼ばれる
    else
      # errorレスポンス送る。下のprivateに定義
      render_error_turbo_stream
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def render_error_turbo_stream
    render turbo_stream: turbo_stream.replace(
      "emo_count_for_post_#{@post.id}",
      partial: "emo_count",
      locals: { post: @post }),
    status: :unprocessable_entity
  end
end
