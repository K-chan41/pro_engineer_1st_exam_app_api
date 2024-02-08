FactoryBot.define do
  factory :flag do
    association :user
    association :question
  end
end
