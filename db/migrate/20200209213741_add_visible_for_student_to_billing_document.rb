class AddVisibleForStudentToBillingDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_documents, :visible_for_student, :boolean
  end
end
