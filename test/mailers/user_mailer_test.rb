require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "reset_password_email" do
    skip "Password reset mailer test skipped"
    user = users(:one)
    user.generate_reset_password_token!

    mail = UserMailer.reset_password_email(user)

    assert_equal "パスワードリセット", mail.subject
    assert_equal [ user.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match user.email, mail.body.encoded
  end
end
