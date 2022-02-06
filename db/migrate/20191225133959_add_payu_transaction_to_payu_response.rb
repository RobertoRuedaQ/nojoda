class AddPayuTransactionToPayuResponse < ActiveRecord::Migration[5.2]
  def change
    add_reference :payu_responses, :payu_transaction, foreign_key: true
    add_column :payu_responses, :pending_reason, :string
    add_column :payu_responses, :error_code, :string
    add_column :payu_responses, :transaction_date, :date
    add_column :payu_responses, :transaction_time, :string
    add_column :payu_responses, :reference_questionnaire, :string
    add_reference :payu_responses, :additional_info, index: true
  end
end
