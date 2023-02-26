FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      after(:create) do |user|
        user.roles << create(:role, :admin)
      end
    end

    trait :moderator do
      after(:create) do |user|
        user.roles << create(:role, :moderator)
      end
    end
  end
end
