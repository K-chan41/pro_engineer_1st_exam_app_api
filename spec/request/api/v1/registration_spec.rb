RSpec.describe 'Api::V1::Registration', type: :request, autodoc: true do
  # let(:request_hash) { { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { user: user_attributes }.to_json } }

  describe 'POST /registration' do
    context 'emailとpasswordが有効な場合' do
      let(:user_attributes) { attributes_for(:user) }
      it 'userがjson形式で返ってくる' do
        post api_v1_registration_path, params: { user: user_attributes }.to_json, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

        json_response = JSON.parse(response.body)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['name']).to eq(user_attributes[:name])
        expect(json_response['data']['attributes']['email']).to eq(user_attributes[:email])
        expect(response.headers['AccessToken']).to be_present
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context 'emailとpasswordが無効な場合' do
      let(:user_attributes) { attributes_for(:user, name: nil, email: nil, password: nil) }
      it 'エラーがjson形式で返ってくる' do
        post api_v1_registration_path, params: { user: user_attributes }.to_json, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to eq(["Name can't be blank", "Email can't be blank"])
        expect(response.headers['AccessToken']).to be_blank
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /registration' do
    context 'emailとpasswordが有効な場合' do
      let(:headers) { { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }
      let(:user) { create(:user) }
      let(:api_key) { create(:api_key, user: user) }
      let(:auth_headers) { headers.merge('Authorization' => "Bearer #{api_key.access_token}") }
      it 'userが削除できる' do
        post api_v1_authentication_path, params: { user: user }.to_json, headers: headers
        delete api_v1_registration_path, params: { user: user }.to_json, headers: auth_headers

        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('User successfully deleted.')
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end
end
