module RestrictedCompanies
  extend ActiveSupport::Concern

  included do
    before_action :set_restricted_companies, only: [:new, :edit, :create] 
  end
  
  private

  def set_restricted_companies
    @restricted_companies_for_log_in = [21,2,7,8]
  end

end