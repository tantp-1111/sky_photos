require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "should create password reset" do
    user = users(:one)
    post password_resets_url, params: { email: user.email }
    assert_redirected_to login_url
  end

  test "should get edit" do
    user = users(:one)
    user.deliver_reset_password_instructions!
    get edit_password_reset_url(user.reset_password_token)
    assert_response :success
  end

  test "should update password" do
    user = users(:one)
    user.deliver_reset_password_instructions!

    patch password_reset_url(user.reset_password_token), params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword"
      }
    }
    assert_redirected_to login_url
  end
end
