require "test_helper"

class Api::V1::SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_subjects_index_url
    assert_response :success
  end
end
