class PaymentMassDetail < ApplicationRecord
      
      resourcify
      audited
  belongs_to :payment, optional: true
  belongs_to :payment_mass
  belongs_to :billing_document, optional: true
  belongs_to :fund,optional: true
  has_many :payment_mass_doc, dependent: :destroy

  before_save :set_account_case
  before_save :set_detail_status
  after_commit :flush_cache_payment_mass_detail
  has_one_attached :payment_support



  scope :pending_to_pay, -> {joins(:payment_mass_doc).where(problem_case: 'none',payment_mass_docs: {status: 'selected'}).where.not(status: 'matched')}



  def generate_payment

    self.payment_mass_doc.selected.each do |doc|
      if self.fund_name != doc.fund_name
        self.update(fund_name: doc.fund_name)
      end
      if self.matches_count == 1 && doc.value != self.value
        doc.update(value: self.value)
      end
      if !doc.payment.nil? && doc.payment.value != doc.value
        doc.payment.update(value: doc.value)
        doc.payment.match_payments
      else
        Payment.create(billing_document_id: doc.billing_document_id, status: "active",payment_source: "payment_mass", payment_method: "payment_mass", value: doc.value, resource_type: "PaymentMassDoc", resource_id: doc.id, payment_date: self.transaction_date)
      end
    end

    self.set_detail_status
    self.save
  end

  def set_detail_status
    if self.value.to_f == self.payment_generated_value
      self.status = 'matched'
    elsif self.value.to_f < self.payment_generated_value
      self.status = 'over_payed'
    elsif self.payment_generated_value == 0
      self.status = 'pending_match'
    elsif self.value.to_f > self.payment_generated_value
      self.status = 'partial_match'
    end
  end

  def payment_generated_value
    Payment.joins(payment_mass_doc: :payment_mass_detail).where('payment_mass_details.id = ?', self.id).sum(:value)
  end


  def set_account_case
    if !self.bank_account.nil?
      self.account_case = self.bank_account.specific_use
      self.fund_id = self.bank_account.resource_id
      self.fund_name = self.bank_account.resource.name
    end
  end

  def flush_cache_payment_mass_detail
    Rails.cache.delete(['n_matches_PaymentMassDetail',self.id]){payment_mass_doc.count}
    Rails.cache.delete(['names_matches_PaymentMassDetail',self.id]){raw_user_names}
    Rails.cache.delete(['funds_matches_PaymentMassDetail',self.id]){raw_user_funds}
  end

  def value_pending_to_apply evaluated_doc
    pending = self.value.to_f - self.payment_mass_doc.where(status: 'selected').where.not(id: evaluated_doc).sum(:value).to_f
    [pending,0].max
  end


  def n_matches
    Rails.cache.fetch(['n_matches_PaymentMassDetail',self.id]){payment_mass_doc.count}
  end

  def names_matches
    Rails.cache.fetch(['names_matches_PaymentMassDetail',self.id]){raw_user_names}
  end

  def funds_matches
    Rails.cache.fetch(['funds_matches_PaymentMassDetail',self.id]){raw_user_funds}
  end


  def raw_user_identification_numbers
    users = self.users
    if !users.nil?
      @result = self.users.map{|u| u.identification_number}.uniq.join(', ')
    end
    return @result
  end


  def raw_user_names
    users = self.users
    if !users.nil?
      @result = self.users.map{|u| u.name}.uniq.join(', ')
    end
    return @result
  end

  def raw_user_funds
    users = self.users
    if !users.nil?
      @result = self.users.map{|u| u.funds_names}.uniq.join(', ')
    end
    return @result
  end

  def users
    target_ids = User.joins(isa: [billing_document: [payment_mass_doc: :payment_mass_detail]]).where('payment_mass_details.id = ? AND payment_mass_docs.status != ?',self.id,'rejected').ids
    if target_ids.count > 0
      @result = User.where(id: target_ids)
    end
    return @result
  end

  def bank_account
    BankAccount.where(account_number: self.bank_number, resource_type: "Fund").first
  end

  def wrong_fund? billing_document
    if !self.bank_account.nil?
      result = billing_document.fund.id == self.bank_account.resource_id
    else
      result = false
    end
    return result
  end

  def disbursement_account?
    if !self.bank_account.nil?
      result = self.bank_account.specific_use == 'tuition'
    else
      result = false
    end
    return result
  end

  def get_billing_document_id
    if (self.ref_1.size > 3 && self.ref_2.size > 3 && ![self.ref_1,self.ref_2].include?(self.bank_number)) || !self.identification_number.nil?
      # We need to user two independent queries because not all students has banck_account. The would prevent find the right answer.

      if self.identification_number.nil?
        isa_ids_first = Isa.joins(billing_document: [payment: [payment_mass_doc: :payment_mass_detail]]).
                  where('payment_mass_details.ref_1 = ? OR payment_mass_details.ref_2 = ? OR payment_mass_details.ref_1 = ? OR payment_mass_details.ref_2 = ?',
                    self.ref_1,self.ref_1,self.ref_2,self.ref_2).ids.uniq


        isa_ids_second = Isa.joins(user: :bank_account).
                  where('bank_accounts.account_number = ? OR bank_accounts.account_number = ?',
                    self.ref_1,self.ref_2).ids.uniq

        isa_ids_third = Isa.joins(:user).
                  where('users.identification_number = ? OR users.identification_number = ?',
                    self.ref_1,self.ref_2).ids.uniq

        isa_ids = (isa_ids_first + isa_ids_second + isa_ids_third).uniq
      else
        custom_ids = self.identification_number.split(',')
        isa_ids = Isa.joins(:user).where(users: {identification_number: custom_ids}).ids
        self.payment_mass_doc.destroy_all
        # self.payment_mass_doc.joins(billing_document: [isa: :user]).where('users.identification_number NOT IN (?)',custom_ids).update_all(status: 'rejected')
        # self.payment_mass_doc.joins(billing_document: [isa: :user]).where('users.identification_number IN (?)',custom_ids).update_all(status: 'selected')
        self.update(matches_count: isa_ids.count)
      end


      if isa_ids.count == 0


        target_users = User.joins(isa: [funding_option: [application: [funding_opportunity_from_resource: [fund: :bank_account]]]]).where('bank_accounts.account_number = ?',self.bank_number)
        if target_users.count > 0
          user = target_users.searcher_by_name self.ref_1
          if user.nil?
            user = target_users.searcher_by_name self.ref_2
          end

          if !user.nil?
            case self.account_case
            when 'repayment'
              billing_documents = BillingDocument.joins(isa: :user).where(isas: {users: {id: user.ids}}).where(active: true)
            when 'tuition'
              disbursement_request = DisbursementRequest.to_be_matched.joins(application: :user).where(applications: {users: {id: user.ids}}).where(value_payed_by_student: self.value)
            when 'repayment_and_tuition'
              disbursement_request = DisbursementRequest.to_be_matched.joins(application: :user).where(applications: {users: {id: user.ids}}).where(value_payed_by_student: self.value)
              if disbursement_request.count == 0 
                billing_documents = BillingDocument.joins(isa: :user).where(isas: {users: {id: user.ids}}).where(active: true)
              end
            end
          end
        end

      else
        case self.account_case
        when 'repayment','repayment_and_tuition'

          if self.account_case == 'repayment_and_tuition' && self.billing_document_id.nil?
            disbursement_request = get_disbursement_request_for_tuition(isa_ids)
          end
          

          if defined?(disbursement_request).nil? || 
            (!defined?(disbursement_request).nil? && disbursement_request.nil?) || 
            (!defined?(disbursement_request).nil? && !disbursement_request.nil? && disbursement_request.count == 0 )

            active_billing_documents = BillingDocument.where(isa_id: isa_ids,active: true)

            remaining_isas = isa_ids - active_billing_documents.pluck(:isa_id)

            if active_billing_documents.count == 0
              inactive_billind_documents = []
              remaining_isas.each do |remaining_id|
                temp_document = Isa.find(remaining_id).billing_document.first
                if !temp_document.nil?
                  inactive_billind_documents += [temp_document.id]
                end
              end
              billing_documents = BillingDocument.where(id: inactive_billind_documents)
            else
              billing_documents = active_billing_documents
            end
          end


        when 'tuition'
          disbursement_request = get_disbursement_request_for_tuition(isa_ids)
        end

      end



      if (!defined?(billing_documents).nil? && !billing_documents.nil? && billing_documents.count > 1 ) || (!defined?(disbursement_request).nil? && !disbursement_request.nil? && disbursement_request.any? )
        problem = 'pending'
        doc_status = 'pending'
      else
        problem = 'none'
        doc_status = 'selected'
      end



      if PaymentMassDetail.where(key: self.key).where.not(id: self.id).count > 0
        problem = 'duplicated'
      end


      if !defined?(disbursement_request).nil? && !disbursement_request.nil?
        if disbursement_request.count > 0
          disbursement_request.each do |disbursement_request_detail|
            new_document = PaymentMassDoc.find_or_create_by(disbursement_request_id: disbursement_request_detail.id,payment_mass_detail_id: self.id)
            if !['selected','rejected'].include?(new_document.status)
              new_document.status = doc_status
              new_document.save
            end

            self.update(status: 'pending_match',problem_case: problem)
          end
        else
          self.update(status: 'pending_match',problem_case: 'incognito')
        end
      end


      if !defined?(billing_documents).nil? && !billing_documents.nil?
      	if billing_documents.count > 0
          billing_documents.each do |billing_document|
            new_document = PaymentMassDoc.find_by(billing_document_id: billing_document.id,payment_mass_detail_id: self.id)
            if new_document.nil?
        		  new_document = PaymentMassDoc.new({billing_document_id: billing_document.id,payment_mass_detail_id: self.id})
            end
            if !['selected','rejected'].include?(new_document.status)
              new_document.status = doc_status
              new_document.save
            end

            self.update(status: 'pending_match',problem_case: problem)
          end
        else
          self.update(status: 'pending_match',problem_case: 'incognito')
      	end
      end


    else
      self.update(status: 'pending_match' ,problem_case: 'incognito' )
    end

    pending_docs = self.payment_mass_doc.where(status: 'pending')

    if pending_docs.count > 0
      pending_docs.map{|doc| doc.update(status: 'selected' )}
    end


    if self.payment_mass_doc.where(status: 'selected').count > 0 && (self.payment_mass_doc.where(status: 'selected').sum(:value) * (1 + self.payment_mass.margin_error.to_f/100)) < self.value
      self.update(status: 'pending_match',problem_case: 'too_big')
    elsif self.payment_mass_doc.where(status: 'selected').count > 1
      self.update(status: 'pending_match',problem_case: 'multiple_options')
    end

    self.update(matches_count: self.payment_mass_doc.where(status: 'selected').count)

    # problem_cases = ['incognito','too_big','invalid_fund']
    # status = ['pending_match','partial_match','matched']
  end

  def get_disbursement_request_for_tuition(isa_ids)
    disbursement_query =  DisbursementRequest.includes(application: [:user, disbursement: [funding_option: :isa]]).where(applications: { status: 'approved'})
  
    if self.disbursement_id.present?
      get_disbursement_request_for_tuition_by_disbursement(isa_ids, disbursement_query)
    else
      disbursement_query.where('isas.id IN (?) AND disbursement_requests.value_payed_by_student = ?',isa_ids,self.value)
    end
  end

  def get_disbursement_request_for_tuition_by_disbursement(isa_ids, disbursement_query)
    result = disbursement_query.where('isas.id IN (?) AND disbursements.id = ?', isa_ids, self.disbursement_id)
    result if  result.any?
    
    disbursement_query.where(applications: { users: { identification_number: self.identification_number}})
                      .where('disbursements.id = ?', self.disbursement_id)
  end


  def unapply_payment
    payments.destroy_all
  end

  def payments
    Payment.joins(:payment_mass_doc).where(payment_mass_docs: { payment_mass_detail_id: self })
  end
end
