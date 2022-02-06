class AddAgreementCodeToWompi < ActiveRecord::Migration[5.2]
  def change
    add_column :wompi_gateways, :agreement_code, :string, default: ''
  end
end
