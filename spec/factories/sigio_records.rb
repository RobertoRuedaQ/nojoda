FactoryBot.define do
  factory :sigio_record do
    legal_match { nil }
    user { nil }
    id_transaction { "MyString" }
    Id_contract_document { "MyString" }
    id_promissory_document { "MyString" }
    id_student_in_signio { "MyString" }
    id_jointly_liable_in_signio { "MyString" }
    id_legal_representative_in_signio { "MyString" }
    id_zigma_representative_in_signio { "MyString" }
    tag_coordinates { "" }
  end
end
