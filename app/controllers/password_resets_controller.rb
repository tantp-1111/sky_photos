class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    Rails.logger.info "=== Password reset started for email: #{params[:email]} ==="
  @user = User.find_by(email: params[:email])
  
  if @user
    Rails.logger.info "=== User found, sending email... ==="
    begin
      @user.deliver_reset_password_instructions!
      Rails.logger.info "=== Email sent successfully ==="
    rescue => e
      Rails.logger.error "=== Email sending failed: #{e.message} ==="
      Rails.logger.error e.backtrace.join("\n")
    end
  end
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
