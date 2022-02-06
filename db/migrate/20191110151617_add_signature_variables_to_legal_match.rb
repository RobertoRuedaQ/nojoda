class AddSignatureVariablesToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_matches, :identity_check_text, :string
    add_column :legal_matches, :signer_ip, :string
  end
end
