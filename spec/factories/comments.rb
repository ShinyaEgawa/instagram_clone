FactoryBot.define do
  factory :comment do
    content "sample comment"
    association :micropost
    user { micropost.user }
    trait :today do
      created_at 1.hour.ago
    end
    trait :yesterday do
      created_at 1.day.ago
    end
  end
end
