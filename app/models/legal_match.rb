class LegalMatch < ApplicationRecord
  resourcify
  audited
	include LumniOrigination

  belongs_to :user, touch: true
  belongs_to :legal_document
  belongs_to :application, optional: true, touch: true
  belongs_to :resource, polymorphic: true, optional: true, touch: true
  belongs_to :parent, class_name: 'LegalMatch', foreign_key: 'parent_id', optional: true

  has_one_attached :scanned_document
  has_many_attached :additional_support

  after_commit :set_uploaded_status



  def name
  	self.legal_document.name
  end

  def document_type
  	self.legal_document.document_type
  end

  def set_uploaded_status
    if self.status != 'pending_for_scan' && !self.scanned_document.attached? && self.pending_for_scan
      self.update(status: 'pending_for_scan')
    elsif self.status != 'attached' && self.scanned_document.attached?
      self.update(status: 'attached',pending_for_scan: false)
    elsif self.status == 'attached' && !self.scanned_document.attached?
      self.update(status: 'downloaded')
    end
  end

end
