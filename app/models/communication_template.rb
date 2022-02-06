class CommunicationTemplate < ApplicationRecord
    resourcify
  audited
	
  belongs_to :company
  belongs_to :communication_case
  belongs_to :communication_header
  belongs_to :communication_footer

  def case_name 
  	self.communication_case.title
  end
end
