class CommunicationFooter < ApplicationRecord
    resourcify
  audited

  belongs_to :company
  has_many :communication_template
end
