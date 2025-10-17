require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "should create password reset" do
    post password_resets_url, params: { email: "user@example.com" }
    assert_redirected_to login_url
  end

  test "should get edit" do
    get edit_password_reset_url("dummy_token")
    assert_response :success
  end

  test "should update password" do
    patch password_reset_url("dummy_token"), params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword"
      }
    }
    # 成功時にloginへリダイレクト
    assert_redirected_to login_url
  end
end
