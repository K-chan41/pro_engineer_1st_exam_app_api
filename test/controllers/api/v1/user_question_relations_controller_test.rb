require "test_helper"

class Api::V1::UserQuestionRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_user_question_relations_create_url
    assert_response :success
  end
end
