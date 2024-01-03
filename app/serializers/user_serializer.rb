class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :created_at, :updated_at

  has_many :user_question_relations, serializer: UserQuestionRelationSerializer
  has_many :flags, serializer: FlagSerializer
end
