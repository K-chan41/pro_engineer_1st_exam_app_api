FactoryBot.define do
  factory :user_question_relation do
    answer { 1 }
    association :user
    association :question
  end
end
