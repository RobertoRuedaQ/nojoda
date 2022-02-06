FactoryBot.define do
  factory :valuation_detail do
    date { "2020-11-10" }
    student_flow { 1.5 }
    fund_flow { 1.5 }
    investor_flow { 1.5 }
    fees { 1.5 }
    valuation_history { nil }
  end
end
