class Reference < ApplicationRecord
      
      resourcify
      audited
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true
  belongs_to :user, touch: true


	has_one_attached :reference_work_certificate
	has_one_attached :identification_document_image
  has_one_attached :credit_check_autoreport
  has_one_attached :rfc_support
  has_one_attached :service_bill
  has_one_attached :reference_curp_support


  before_save :set_row

  def set_row
    if self.row.nil?
      rows = self.user.reference.pluck(:row).compact
      new_row = rows.count == 0 ? 0 : rows.max + 1
      self.row = new_row
    end
  end  

  def name
    result = self.first_name if !self.first_name.nil?
    result += ' ' + self.middle_name if !self.middle_name.nil?
    result += ' ' + self.last_name if !self.last_name.nil?
  end

  def country_name
    if !self.country.nil?
      @response = self.country.label
    end
    return @response
  end

  def state_name
    if !self.state.nil?
      @response = self.state.label
    end
    return @response
  end

  def city_name
    if !self.city.nil?
      @response = self.city.label
    end
    return @response
  end

  def reference_document_type_for_signio
    case self.indentification_case
    when 'cedula','cc'
      return 'CC'
    when 'immigration_cedula', 'ce'
      return 'CE'
    when 'Pasaporte', 'passport', 'Pasaport'
      return 'PS'
    when 'ti'
      return 'TI'
    else
      return 'OT'
    end
  end


  

end
