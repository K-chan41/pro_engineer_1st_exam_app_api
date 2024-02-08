RSpec.describe 'Api::V1::Authentication', type: :request, autodoc: true do
  let(:password) { 'password' }
  let!(:user) { create(:user, password: password) }

  describe 'POST /authentication' do
    context 'emailとpasswordが有効なとき' do
      it 'user情報をjson形式で返答' do
        post api_v1_authentication_path, params: { user: { email: user.email, password: password } }.to_json, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

        json_response = JSON.parse(response.body)
        expect(json_response['data']['id'].to_i).to eq(user.id)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['name']).to eq(user.name)
        expect(json_response['data']['attributes']['email']).to eq(user.email)
        expect(response.headers['AccessToken']).to be_present
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context 'emailとpasswordが無効なとき' do
      it 'Invalid email or passwordが返ってくる' do
        post api_v1_authentication_path, params: { user: { email: user.email, password: 'wrong_password' } }.to_json, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid email or password')
        expect(response).to have_http_status(422)
      end
    end
  end
end
