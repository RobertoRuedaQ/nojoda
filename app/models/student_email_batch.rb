class StudentEmailBatch < ApplicationRecord
audited

validates :email_case, presence: :true
has_one_attached :email_list

after_save :update_status

def update_status
  self.update_column('status', 'completed')
end

def get_records
  begin
    require 'csv' 
    csv_text = self.email_list.attachment.download
    csv = CSV.parse(csv_text, headers: true)
    csv.map{|r| r.to_h}
  rescue Exception => e
  end
end

def valid_file?
  if self.get_records.nil?
    @result = false
  else
    records = self.get_records
    @result = records.first.keys == ['user_id']
  end
  return @result
end

end
