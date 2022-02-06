class RemoveReferencesFromPayuResponse < ActiveRecord::Migration[5.2]
  def change
    remove_reference :payu_responses, :additional_info, index: true
    remove_reference :payu_responses, :billing_document, foreign_key: true
  end
end
