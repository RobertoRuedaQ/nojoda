FactoryBot.define do
  factory :mentory_empleability_invitation do
    accept_invitation { false }
    empleability { false }
    mentory { false }
    user { nil }
  end
end
