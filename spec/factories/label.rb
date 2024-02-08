FactoryBot.define do
  factory :label do
    sequence(:number) { |n| n }
    sequence(:title) { |n| "TitleText#{n}" }
  end
end
