FactoryBot.define do
  factory :choice do
    question
    sequence(:content) { |n| "ContentText#{n}" }
    sequence(:order) { |n| n }
  end
end
