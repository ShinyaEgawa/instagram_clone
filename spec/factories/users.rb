FactoryBot.define do
  factory :user do
    name "Example"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "password"
    password_confirmation "password"
    admin true

    factory :other_user do
      name "OtherUser"
      sequence(:email) { |n| "othertester#{n}@example.com" }
      password "password"
      password_confirmation "password"
    end
  end
end
