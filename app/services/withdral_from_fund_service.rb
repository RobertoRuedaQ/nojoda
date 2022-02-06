class WithdralFromFundService

  def self.for(isa_id)
    new(isa_id).perform
  end

  def initialize(isa_id)
    @isa = Isa.find(isa_id)
  end


  def perform
    cancel_disbursements
    change_status_to_isa
  end

  private
   
  def cancel_disbursements
    disbursements_to_update = @isa.funding_option.disbursement.reject{|d| d.stored_general_status == "payed" || d.stored_general_status == "partially_payed"}
    disbursements_to_update.each{|d| d.update(status:'canceled')}
  end

  def change_status_to_isa
    @isa.set_new_status('general_status','retired', DateTime.now, end_date = nil)
  end

end