FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:email) { |n| "user+#{n}@example.com" }
    password { 'password' }
  end
end
