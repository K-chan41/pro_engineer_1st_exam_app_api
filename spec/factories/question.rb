FactoryBot.define do
  factory :question do
    association :subject
    association :label
    sequence(:number) { |n| n }
    sequence(:content) { |n| "ContentText#{n}" }
    sequence(:question_img_src) { |n| "QuestionImageSrc#{n}" }
    sequence(:correct_answer_no) {  rand(1..5) }
    sequence(:commentary) { |n| "CommentaryText#{n}" }
    sequence(:answer_img_src) { |n| "AnswerImageSrc#{n}" }
  end
end
