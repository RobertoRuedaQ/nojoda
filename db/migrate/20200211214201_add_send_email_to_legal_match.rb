class AddSendEmailToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_matches, :send_email, :boolean, default: true
  end
end
