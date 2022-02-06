class PaymentBatch < ApplicationRecord
  include LumniCollection
      
      resourcify
      audited
  belongs_to :fund
  has_many :billing_document, dependent: :destroy
  has_many :batch_detail, dependent: :destroy
  scope :from_my_companies, ->(companies_id){joins(:fund).where(funds: {company_id: companies_id})}

  after_commit :manage_billing_documents

  def fund_name
  	self.fund.name
  end

  def manage_billing_documents
    if self.status == 'finale_close'
      self.update(status: 'processing_final_close')
      if Rails.env == 'production'
        CollectionAsync.perform_async(self.id,'activate_billing_documents')
      else
        activate_billing_documents(self.id)
      end
    elsif self.status == 'partial_close'
      self.update(status: 'processing_partial_close')

      if Rails.env == 'production'
        CollectionAsync.perform_async(self.id,'generate_billing_documents')
      else
        generate_billing_documents(self.id)  
      end
    end
  end


  def billing_documents_date
    Date.new(self.year, self.month)
  end
end
