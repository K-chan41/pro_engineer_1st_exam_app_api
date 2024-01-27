FactoryBot.define do
  factory :subject do
    sequence(:year) { |n| "Year#{n}" }
    sequence(:exam_subject) { |n| n }
  end
end
