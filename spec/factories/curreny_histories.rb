FactoryBot.define do
  factory :curreny_history do
    currency_base { "MyString" }
    currency_target { "MyString" }
    date { "2020-10-16" }
    value { 1.5 }
  end
end
