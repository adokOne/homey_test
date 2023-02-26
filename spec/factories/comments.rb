FactoryBot.define do
  factory :comment do
    text { 'MyText' }
    user
    project
    comment { nil }
  end
end
