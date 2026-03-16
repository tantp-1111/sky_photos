class UserMailer < ApplicationMailer
  def reset_password_email(user)
    return if Rails.env.test?
    # パスワードリセット用のURLを生成
    reset_url = edit_password_reset_url(user.reset_password_token)

    # initializerで設定したResendクライアントを使用
    client = Resend::Client.new(ENV["RESEND_API_KEY"])

    html = ApplicationController.render(
      template: "user_mailer/reset_password_email",
      assigns: { user: user, url: reset_url }
    )
    # views/user_mailer/reset_password_email.html.erbを使用するにあたり、変数頭の@を削除

    client.emails.create(
      from: "onboarding@resend.dev", # resendが提供するメールアドレスを使用
      to: user.email,
      subject: I18n.t("defaults.password_reset"),
      html: html
    )
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
