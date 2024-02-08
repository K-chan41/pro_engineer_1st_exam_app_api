RSpec.describe 'Api::ExceptionHandler', type: :request, autodoc: true do
  let!(:user) { create(:user) }
  let!(:api_key) { create(:api_key, user: user) }

  describe '500エラー' do
    it 'エラーを発生するとjson formatで返って来る' do
      allow(Question).to receive(:all).and_raise(StandardError)
      get filter_api_v1_questions_path, params: { subject_ids: 1 }, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" }

      parsed_body = JSON.parse(response.body)
      expect(parsed_body['message']).to eq('Internal Server Error')
      expect(response).to have_http_status(500)
    end
  end

  describe '404エラー' do
    it 'エラーを発生するとjson formatで返って来る' do
      get filter_api_v1_questions_path, params: { subject_ids: 999 }, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" }

      parsed_body = JSON.parse(response.body)
      expect(parsed_body['message']).to eq('Record Not Found')
      expect(response).to have_http_status(404)
    end
  end
end
