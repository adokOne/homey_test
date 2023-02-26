FactoryBot.define do
  factory :role do
    trait :admin do
      name { 'admin' }
    end
    trait :moderator do
      name { 'moderator' }
    end
  end
end
