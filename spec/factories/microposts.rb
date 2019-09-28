FactoryBot.define do
  factory :micropost, class: Micropost do
    content { Faker::Lorem.sentence(5) }
    association :user, factory: :user
    trait :today do
      created_at 1.hour.ago
    end
    trait :yesterday do
      created_at 1.day.ago
    end
  end
end
