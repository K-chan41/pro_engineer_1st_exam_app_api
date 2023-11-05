class LabelSerializer
  include JSONAPI::Serializer
  attributes :number, :title

  has_many :questions, serializer: QuestionSerializer
end
