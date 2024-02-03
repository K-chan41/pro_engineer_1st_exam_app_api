require 'rails_helper'

RSpec.describe 'Api::V1::Questions', type: :request, autodoc: true do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }
  let(:user) { create(:user) }
  let(:api_key) { create(:api_key, user: user) }
  let(:auth_headers) { headers.merge('Authorization' => "Bearer #{api_key.access_token}") }

  describe 'GET /questions/filter' do
    let(:subject) { create(:subject) } # Subjectインスタンスを作成
    let(:subject_ids) { [subject.id] } # SubjectのIDを使用
    let!(:expected_question) { create(:question, subject: subject) } # Subjectに関連付けたQuestionを作成

    it 'subject_idsに合致したquestionsがjson形式で返ってくる' do
      get filter_api_v1_questions_path, params: { subject_ids: subject_ids }, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response['data']).not_to be_empty

      first_question = json_response['data'].first
      response.body
      expected_question
      expect(first_question['attributes']['content']).to eq(expected_question.content) # 期待する問題が返ってきているか確認
    end
  end

  describe 'GET /questions/shuffle' do
    before do
      create_list(:question, 10) # テスト用のQuestionレコードを10件作成
    end

    it 'ランダム出題の際にjson形式で10問返ってくるか' do
      get shuffle_api_v1_questions_path, headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response['data'].size).to eq(10) # 10問あるか確認
    end
  end

  describe 'GET /questions/recent_mistakes' do
    let(:current_user) { create(:user) }
    let!(:mistakes) { create_list(:user_question_relation, 10, user: current_user, answer: 1) } # 回答を作成
  
    it '最近間違えた問題がjson形式で10問以下返ってくるか' do
      get recent_mistakes_api_v1_questions_path, headers: auth_headers
  
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
  
      json_response = JSON.parse(response.body)
      response.body
      expect(json_response['data'].size).to be <= 10 # 10問以下を確認
    end
  end

  describe 'GET /questions/flagged_questions' do
    let(:current_user) { create(:user) }
    let!(:flags) { create_list(:flag, 10, user: current_user) } # フラグを設定
  
    it 'フラグした問題がjson形式で10問以下返ってくるか' do
      get flagged_questions_api_v1_questions_path, headers: auth_headers
  
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
  
      json_response = JSON.parse(response.body)
      response.body
      expect(json_response['data'].size).to be <= 10 # 10問以下を確認
    end
  end
end
