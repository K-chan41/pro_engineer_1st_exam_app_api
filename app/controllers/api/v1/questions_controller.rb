class Api::V1::QuestionsController < Api::V1::BaseController
  def filter
    subject_ids = params[:subject_ids]
    # Eager loading of related models
    questions = Question.includes(:subject, :label, :choices).where(subject_id: subject_ids)
    
    # Use the QuestionSerializer to serialize the questions along with their related models
    json_string = QuestionSerializer.new(questions, include: [:subject, :label, :choices]).serializable_hash.to_json
    render json: json_string
  end
end
