require "test_helper"

class OauthsControllerTest < ActionDispatch::IntegrationTest
  test "should get oauth" do
    skip "Google OAuthテストはスキップ"
    get oauths_oauth_url
    assert_response :success
  end

  test "should get callback" do
    skip "Google OAuthテストはスキップ"
    get oauths_callback_url
    assert_response :success
  end
end
