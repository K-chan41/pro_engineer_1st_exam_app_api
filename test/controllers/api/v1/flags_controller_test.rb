require "test_helper"

class Api::V1::FlagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_flags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_flags_destroy_url
    assert_response :success
  end
end
