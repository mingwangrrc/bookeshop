require "test_helper"

class BuyNowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get buy_now_show_url
    assert_response :success
  end

  test "should get success" do
    get buy_now_success_url
    assert_response :success
  end
end
