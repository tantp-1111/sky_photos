class UserMailer < ApplicationMailer
  def reset_password_email(user)
    return if Rails.env.test?
    # パスワードリセット用のURLを生成
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)

    mail( to: user.email, subject: I18n.t("defaults.password_reset") )
  end
  # default from: "tantpapp@gmail.com"
  # 送信元のメールアドレス

  # パスワードリセットメソッド,token作成したurl発行
  # def reset_password_email(user)
  #  @user = user
  #   @url  = edit_password_reset_url(@user.reset_password_token)
  #   mail(
  #     to: user.email,
  #     subject: t("defaults.password_reset")
  #   )
  # end
end
