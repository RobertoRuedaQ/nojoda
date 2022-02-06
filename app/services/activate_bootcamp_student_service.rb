class ActivateBootcampStudentService

    def self.for(user_id)
      user = User.find(user_id) 
      return if user.nil?

      new(user).perform
    end
  
    def initialize(user)
      @user = user
    end
  
    def perform
      return process_activation
    end

  private

  def isa
    @user.active_isa.first
  end

  def disbursement
    Disbursement.joins(:application).where(disbursement_case: "tuition").where(applications: { user_id: @user.id}).first
  end


  def update_disbursement
    if disbursement.stored_general_status != 'payed'
      disbursement.update(isa_id: isa.id) if disbursement.isa.nil?
    end
  end
    
  def application_for_disbursement
    application = Application.find_or_create_by({ 
      status: 'active',
      user_id: @user.id, 
      application_case: 'disbursement_request', 
      resource_type: 'Disbursement', 
      resource_id: disbursement.id
      })
  end

  def disbursement_request
    disbursement_request = DisbursementRequest.find_or_create_by({
      application_id: application_for_disbursement.id,
      tuition_value: disbursement.student_value, 
      status: 'active', 
      due_date: Time.now.to_date, 
      request_case: 'student_request', 
      tuition_funded_percentage: 100.0, 
      disbursement_value: disbursement.student_value, 
      disbursement_case: 'college_tuition_payment', 
      tuition_due_date_type: 'Ordinaria'
      })
  end

  def update_application
    application_for_disbursement.update({ status: 'approved'})
  end

  def disbursement_payment
    DisbursementPayment.find_or_create_by({
      disbursement_id: disbursement.id, 
      disbursement_request_id: disbursement_request.id, 
      value: disbursement.student_value,
      payment_date: DateTime.now,
      status: "payed"
      })
  end

  def disbursement_match
    DisbursementMatch.find_or_create_by({
      disbursement_id: disbursement.id, 
      disbursement_request_id: disbursement_request.id, 
      values: disbursement.student_value
    })
  end

  def update_disbursement_status
    disbursement.update(status: 'approved', stored_general_status: 'payed')
  end

  def update_funding_option
    isa.funding_option.touch_cache_variables
  end

  def process_activation
    update_disbursement
    application_for_disbursement
    disbursement_request
    disbursement_payment
    disbursement_match
    update_application
    update_funding_option
    update_disbursement_status
  end
end