class TeamSupervisorBatch < ApplicationRecord
  audited
  has_one_attached :relationships_file
  

  def self.translate_supervisor_role(file_role)
    case file_role
    when 'academica', 'academic'
      return 2
    when 'productiva', 'work'
      return 3
    when 'cobranza', 'collection'
      return 5
    else
      return nil
    end
  end

  def get_records
    begin
      require 'csv'    
      csv_text = self.relationships_file.download
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
      @result = records.first.keys == ['student_id', 'support_email', 'support_type']
    end
    return @result
  end
end
