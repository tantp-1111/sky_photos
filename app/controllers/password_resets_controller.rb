class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    pp 'createスタート'
    @user = User.find_by(email: params[:email])
    pp 'インスタンス変数@userにセット'
    @user&.deliver_reset_password_instructions!
    pp 'メール送信メソッド実行'
    # パスワードをリセットする方法（ランダムなトークンを含むURL）を記載したメールをユーザーに送信
    redirect_to login_path, success: t(".success")
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
    # application_controller.rbにnot_authenticatedメソッド定義,rogin画面にリダイレクト
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t(".success")
    else
      render :edit
    end
  end
end
