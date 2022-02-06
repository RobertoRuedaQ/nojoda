FactoryBot.define do
  factory :user_questionnaire_follow_up do
    user_questionnaire { nil }
    state { "MyString" }
    resolved_at { "2020-10-21 15:52:49" }
    creator_id { 1 }
  end
end
