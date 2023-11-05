class SubjectSerializer
  include JSONAPI::Serializer
  attributes :year, :exam_subject

  has_many :questions, serializer: QuestionSerializer
end
