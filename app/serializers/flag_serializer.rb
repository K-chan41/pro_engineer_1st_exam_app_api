class FlagSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :question_id, :created_at

  belongs_to :user, serializer: UserSerializer
  belongs_to :question, serializer: QuestionSerializer
end
