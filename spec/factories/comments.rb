FactoryBot.define do
  factory :comment do
    text { "MyText" }
    user { nil }
    project { nil }
    comment { nil }
  end
end
