require "test_helper"

class Api::V1::RestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_restaurants_index_url
    assert_response :success
  end
end
