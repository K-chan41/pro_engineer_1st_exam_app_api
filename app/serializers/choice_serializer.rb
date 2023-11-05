class ChoiceSerializer
  include JSONAPI::Serializer
  attributes :content, :order

  belongs_to :question, serializer: QuestionSerializer
end
