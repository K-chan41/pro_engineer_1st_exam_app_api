require 'rails_helper'

RSpec.describe 'Api::V1::Questions', type: :request, autodoc: true do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }

  describe 'GET /questions/filter' do
    let(:subject_ids) { [1] }
    let(:expected_question) { Question.where(subject_id: subject_ids).order(:id).first }
    let!(:expected_question) { create(:question) }

    it 'returns filtered questions with related entities in json format' do
      get filter_api_v1_questions_path, params: { subject_ids: subject_ids }, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_empty

      first_question = json_response['data'].first
      expect(first_question['attributes']['content']).to eq(expected_question.content)
      
      # 追加で、他の属性も検証できます
      # 例: expect(first_question['attributes']['number']).to eq(expected_question.number)
    end
  end
end
