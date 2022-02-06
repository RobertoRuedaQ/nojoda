class AddPayuResponseToPayuAdditionalInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :payu_additional_infos, :payu_response, foreign_key: true
  end
end
