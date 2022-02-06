class StudentTokenBatch < ApplicationRecord
  belongs_to :funding_opportunity
  has_many :funding_token
  
  has_one_attached :tokens_list
  after_save :update_status

  def update_status
    self.update_column('status', 'completed')
  end

  def get_records
    begin
      require 'csv' 
      csv_text = self.tokens_list.attachment.download.force_encoding("UTF-8")
      csv = CSV.parse(csv_text, headers: true)
      csv.map{|r| r[0].split(';')}
    rescue Exception => e
    end
  end

  def valid_file?
    if self.get_records.nil?
      @result = false
    else
      records = self.get_records
      @result = records.first
    end
    return @result
  end
end
