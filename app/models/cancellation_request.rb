class CancellationRequest < ApplicationRecord
  include LumniFinance
      
      resourcify
      audited
  belongs_to :disbursement,optional: true,touch: true
  belongs_to :isa, optional: true
  has_one :application,as: :resource

  has_one_attached :term_grades_support
  has_one_attached :final_grades_support
  has_one_attached :diploma
  has_one_attached :social_work_support
  has_one_attached :work_support


  def funding_opportunity
    if self.disbursement.present?
      @result = self.disbursement.funding_opportunity
    elsif self.isa.present?
      @result = self.isa.funding_opportunity
    end
    @result
  end


  def origination
  	if self.disbursement.present?
	  	@result = self.disbursement.fund.cancellation_origination
  	else
  		@result = self.isa.fund.graduation_cancellation_origination
  	end
  	@result
  end


  def validate_cancellation_config cancellation
    if ['disbursement','automatic'].include?(cancellation.ejecution_type)
      gpa = self.term_gpa.to_f
    elsif 
      gpa = self.final_gpa.to_f
    end

    if self.company_start_date.present?
      if self.company_end_date.present?
        end_date = self.company_end_date
      else
        end_date = Time.now.to_date
      end
      @certified_work_months = months_between self.company_start_date, end_date
    end

    (cancellation.minimum_grade <= gpa && cancellation.maximum_grande > gpa) || 
    (cancellation.social_work_hours.present? && self.social_hours.present? && cancellation.social_work_hours.to_f <= self.social_hours.to_f) ||
    (cancellation.certified_work_months.present? && self.company_start_date.present? && @certified_work_months.to_f >= cancellation.certified_work_months.to_f)
  end

end
