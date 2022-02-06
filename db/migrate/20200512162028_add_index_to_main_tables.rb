class AddIndexToMainTables < ActiveRecord::Migration[5.2]
  def change
  	add_index :billing_documents, :reference_date
  	add_index :billing_documents, :status
  	add_index :billing_documents, :due_to_date
  	add_index :billing_documents, :year
  	add_index :billing_documents, :month
  	add_index :billing_documents, :active
  	add_index :billing_documents, :value
  	add_index :billing_documents, :applied_value


  	add_index :users, :searcher_name
  	add_index :users, :status
  	add_index :users, :identification_number

  	add_index :billing_document_details, :status
  	add_index :billing_document_details, :year
  	add_index :billing_document_details, :month
  	add_index :billing_document_details, :value
  	add_index :billing_document_details, :detail_case
  	add_index :billing_document_details, :reference_date
  	add_index :billing_document_details, :applied_value
  	add_index :billing_document_details, :equivalency_covered

  	add_index :payments, :status
  	add_index :payments, :payment_source
  	add_index :payments, :payment_method
  	add_index :payments, :value
  	add_index :payments, :payment_date

  	add_index :funding_opportunities, :status

  	add_index :payment_masses, :status
  	add_index :payment_masses, :margin_error

  	add_index :payment_mass_details, :bank_number
  	add_index :payment_mass_details, :ref_1
  	add_index :payment_mass_details, :ref_2
  	add_index :payment_mass_details, :value
  	add_index :payment_mass_details, :transaction_date
  	add_index :payment_mass_details, :status
  	add_index :payment_mass_details, :problem_case
  	add_index :payment_mass_details, :origin_file_key
  	add_index :payment_mass_details, :row
  	add_index :payment_mass_details, :matches_count
  	add_index :payment_mass_details, :account_case
  	add_index :payment_mass_details, :fund_name
  	add_index :payment_mass_details, :identification_number

  	add_index :payment_mass_docs, :status
  	add_index :payment_mass_docs, :fund_name
  	add_index :payment_mass_docs, :value

  	add_index :isas, :status
  	add_index :isas, :stored_income_status
  	add_index :isas, :stored_payment_status
  	add_index :isas, :stored_general_status


  	add_index :disbursements, :disbursement_case
  	add_index :disbursements, :forcasted_date
  	add_index :disbursements, :stored_general_status





  end
end



