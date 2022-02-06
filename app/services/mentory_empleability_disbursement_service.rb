class MentoryEmpleabilityDisbursementService
  def self.for(application_id)
    new(application_id).perform
  end

  def initialize(application_id)
    @application = Application.find(application_id)
  end

  def perform
    if @application.present?
      disbursements = @application.resource.funding_option.disbursement.select{|d| ['mentory', 'empleability'].include?(d.disbursement_case)}
      disbursements.each{|d| d.do_payment }
    end
  end
end