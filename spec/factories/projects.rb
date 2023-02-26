FactoryBot.define do
  factory :project do
    name { 'MyString' }
    description { 'MyText' }
    status { 1 }
    user
  end
end
