FactoryBot.define do
  factory :black_rock_datum do
    number_of_children { 1 }
    people_in_charge { 1 }
    dependent_on { "MyString" }
    working { "MyString" }
    reasons_to_apply { "MyString" }
    guardian_income { 1 }
    guardian_income_origin { "MyString" }
    family_income_level { "MyString" }
    how_pandemic_affect { "MyText" }
    how_know_about_benefit { "MyString" }
  end
end
