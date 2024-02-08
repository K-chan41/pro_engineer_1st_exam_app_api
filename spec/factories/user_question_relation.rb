FactoryBot.define do
  factory :user_question_relation do
    association :question
    association :user
    answer { 1 }
  end
end
