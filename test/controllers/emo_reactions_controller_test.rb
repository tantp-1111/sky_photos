require "test_helper"

class EmoReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get emo_reactions_create_url
    assert_response :success
  end
end
