class UserQuestionRelationSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :question_id, :answer, :created_at, :updated_at

  belongs_to :user, serializer: UserSerializer
  belongs_to :question, serializer: QuestionSerializer
end
