FactoryBot.define do
  factory :subject do
    sequence(:year) { |n| "Year#{n}" }
    exam_subject { [:basic_subject, :aptitude_subject].sample }
  end
end
