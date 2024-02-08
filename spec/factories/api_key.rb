FactoryBot.define do
  factory :api_key do
    association :user
    sequence(:access_token) { |n| "MyString#{n}" }
    expires_at { 1.weeks.since }
  end
end
