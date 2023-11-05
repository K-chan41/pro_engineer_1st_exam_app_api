class FlagSerializer
  include JSONAPI::Serializer
  attributes :id, :created_at

  belongs_to :user, serializer: UserSerializer
  belongs_to :question, serializer: QuestionSerializer
end
