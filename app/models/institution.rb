class Institution < ApplicationRecord
  include FullTextSearchableConcern
  resourcify
  audited

  after_create :create_contact_info
  after_create :create_location

  has_one :contact_info, as: :resource , dependent: :destroy
  has_one :location, as: :resource , dependent: :destroy
  has_many :major, dependent: :destroy
  has_many :institution_subgroup,class_name: 'InstitutionSubgroup',foreign_key: 'institution_id', dependent: :destroy
  has_many :bank_account, as: :resource , dependent: :destroy

  pg_search_scope :full_text_search, 
                  against: [
                    :id, 
                    :name,
                    :status,
                    :code,
                    :website 
                  ],
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }

  def create_contact_info
    newContact = ContactInfo.new()
    newContact.resource = self
    newContact.save!
  end

  def create_location
    newLocation = Location.new()
    newLocation.resource = self
    newLocation.save!
  end
end
