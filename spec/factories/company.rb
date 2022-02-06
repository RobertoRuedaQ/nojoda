FactoryBot.define do
  factory :company do
    name { 'Lumni Colombia'}
    association :country, factory: :country
    status { 'active' }
    sequence(:url) { |n| "#{company}#{n}.lumniportal.net" }
    default_language { 'en'}
    timezone { 'America/New_York'}
    main_title { 'home.yourcollateral'}
    slogan { 'home.pay_what_you_can'}

    trait :colombia do
      name {'Lumni Colombia'}
    end

    trait :peru do
      name {'Lumni Perú'}
    end

    trait :mexico do
      name {'Lumni México'}
    end

    trait :Argentina do
      name {'Lumni Argentina'}
    end
  end
end