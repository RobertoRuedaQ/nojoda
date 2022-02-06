class EmergencyLivingExpensesPaymentAgreementService
  def self.for(disbursement)
    new(disbursement).perform
  end

  def initialize(disbursement)
    @disbursement = disbursement
  end

  def perform
    return unless @disbursement.instance_of? Disbursement
    return unless @disbursement.disbursement_case ==  'emergency_living_expenses'
    return unless @disbursement.status == 'payed'
    return unless @disbursement.disbursed > 0
      
    @student = @disbursement.user
    @isa = @student.active_isa.first
    payment_agreements = @isa.payment_agreement.where(agreement_case: 'emergency_living_expenses')
    create_payment_agreement(@isa) if payment_agreements.empty?
  end
  
  private

  def create_payment_agreement(isa)
    begin
      academic_status = isa.stored_academic_status
      value = @disbursement.disbursed
      cuota_value = value / 12
      start_date = ''
      time_now = Time.zone.now
      
      start_date =  if academic_status == 'graduated'
                      (time_now + 6.months)
                    else
                      expected_graduation_date = @student.expected_graduation_date
                      if expected_graduation_date > time_now
                        (@student.expected_graduation_date + 6.months)
                      else
                        (time_now + 8.months)
                      end
                    end
      
      PaymentAgreement.create({
        value: value,
        rate: 0.0,
        number_payments: 12,
        status: 'valid',
        agreement_case: 'emergency_living_expenses',
        start_date: start_date,
        cuota_value: cuota_value,
        isa_id: isa.id
      })
    rescue StandardError => error
      logger = Logger.new(STDOUT)
      logger.error(error.message)
    end
  end
end