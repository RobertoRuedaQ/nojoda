class CreateAcademicBonusService

  def self.for(user, date, bonus_value)
    new(user, date, bonus_value).perform
  end

  def initialize(user, date, bonus_value)
    @user = user
    @date = date
    @bonus_value = bonus_value
  end


  def perform
    begin
      if @user.instance_of? User
        @disbursement = create_disbursement
        if @disbursement.instance_of? Disbursement
          @application = create_application
          if @disbursement_request.instance_of? DisbursementRequest
            disbursement_payment = create_disbursement_payment
            if disbursement_payment.instance_of? DisbursementPayment
              @disbursement.update(status: 'approved')
              return result_message(true)
            end
          end
        end
      end
    rescue StandardError => e
      return result_message(false, e)
    end
  end

  private
   
  def create_disbursement
    isa = get_isa
    funding_option = isa.funding_option
    application = funding_option.application
    student_academic = get_student_academic(application)
    disbursement_number = funding_option.disbursement.where(disbursement_case: 'academic_bonus').maximum(:disbursement_number).to_i + 1
    
  
    disbursement = Disbursement.find_by({funding_option_id: funding_option.id , resource_type: 'Isa', resource_id: isa.id, currency: 'COP', disbursement_case: 'academic_bonus', student_value: @bonus_value, company_value: @bonus_value, forcasted_date: @date, request_tuition_support: false, status: 'active', application_id: application.id, student_academic_information_id: student_academic.id, isa_id: isa.id})
  
    if disbursement.nil?
      disbursement = Disbursement.find_or_create_by({funding_option_id: funding_option.id , resource_type: 'Isa', resource_id: isa.id, currency: 'COP', disbursement_case: 'academic_bonus', student_value: @bonus_value, company_value: @bonus_value, forcasted_date: @date, request_tuition_support: false, disbursement_number: disbursement_number, status: 'active', application_id: application.id, student_academic_information_id: student_academic.id, isa_id: isa.id})
    end
    
    return disbursement
  end

  def create_application
    application = Application.create({  status: 'active',user_id: @disbursement.funding_option.isa.user_id, application_case: 'disbursement_request', resource_type: 'Disbursement', resource_id: @disbursement.id})
    @disbursement_request = DisbursementRequest.create({application_id: application.id, tuition_value: @disbursement.student_value, status: 'active', due_date: Time.now.to_date, request_case: 'student_request', tuition_funded_percentage: 100.0, disbursement_value: @disbursement.student_value, disbursement_case: 'college_tuition_payment', tuition_due_date_type: 'Ordinaria'})
    application.update({ result: 'approved', status: 'pending', decision: 'approved'})
  end

  def create_disbursement_payment
    bank_account = @user.bank_account.first
    DisbursementPayment.create({disbursement_id: @disbursement.id, disbursement_request_id: @disbursement_request.id, value: @disbursement.student_value, status: 'sent_to_account', bank_account_id: bank_account.id, payment_case: 'living_expenses_payment'})
  end

  def get_isa
    Isa.includes(funding_option: [:disbursement, :application]).find_by(user_id: @user.id)
  end
  
  def get_student_academic(application)
    application.funded_major || @user.student_academic_information.find_by_information_case('to_be_funded')
  end

  def result_message(success, error = '')
    return {
      success: success,
      error: error,
      user: @user,
      value: @value,
      date: @date,
      academic_bonus: @disbursement
    }
  end
end