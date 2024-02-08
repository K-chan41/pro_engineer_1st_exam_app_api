FactoryBot.define do
  factory :choice do
    association :question
    sequence(:content) { |n| "ContentText#{n}" }
    order { (1..5).to_a.sample }
  end
end
