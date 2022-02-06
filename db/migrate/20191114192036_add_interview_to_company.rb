class AddInterviewToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :interview, index: true
  end
end
