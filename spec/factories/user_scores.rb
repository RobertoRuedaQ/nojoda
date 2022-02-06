FactoryBot.define do
  factory :user_score do
    user { nil }
    score { 1 }
    result { "MyString" }
  end
end
