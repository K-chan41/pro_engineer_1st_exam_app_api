class QuestionSerializer
  include JSONAPI::Serializer
  attributes :number, :content, :question_img_src, :correct_answer_no, :commentary, :answer_img_src

  has_many :choices, serializer: ChoiceSerializer
  belongs_to :subject, serializer: SubjectSerializer
  belongs_to :label, serializer: LabelSerializer, if: Proc.new { |record| record.label.present? }
end
