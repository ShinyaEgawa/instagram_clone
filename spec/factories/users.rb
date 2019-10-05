FactoryBot.define do
  factory :user do
    name "Example user"
    user_name "Example"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "password"
    password_confirmation "password"
    activated true

    factory :other_user do
      name "OtherUser"
      user_name "Other"
      sequence(:email) { |n| "othertester#{n}@example.com" }
      password "password"
      password_confirmation "password"
      activated true
    end
  end
end
