FactoryBot.define do
  factory :valuation_history do
    date { "2020-11-10" }
    user { nil }
    expected_records { 1 }
    status { "MyString" }
  end
end
