require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    post login_url, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get posts_index_url
    assert_response :success
  end
end
