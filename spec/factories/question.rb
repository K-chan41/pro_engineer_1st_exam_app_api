FactoryBot.define do
  factory :question do
    subject
    label
    sequence(:number) { |n| n }
    sequence(:content) { |n| "ContentText#{n}" }
    sequence(:question_img_src) { |n| "QuestionImageSrc#{n}" }
    sequence(:correct_answer_no) {  rand(1..5) }
    sequence(:commentary) { |n| "CommentaryText#{n}" }
    sequence(:answer_img_src) { |n| "AnswerImageSrc#{n}" }

    after(:create) do |question|
      create_list(:choice, 5, question: question)
    end
  end
end
