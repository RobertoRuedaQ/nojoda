FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "#{Faker::Name.first_name}#{n}" }
    sequence(:last_name) { |n| "#{Faker::Name.last_name}#{n}" }
    password {'1234567890'}
    sequence(:email) { |n| "test_#{n}@lumni.net" }
    association :company, factory: :company

    trait :staff do
      type_of_account { 'staff' }
    end

    trait :student do
      type_of_account { 'student'}
    end

    trait :potential_investor do
      type_of_account { 'potential_investor' }
    end
  end
end