class AddOriginationFundedMajorToCompany < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :student_academic_informations, :funded_program
    add_reference :companies, :origination_funded_major, index: true
  end
end
