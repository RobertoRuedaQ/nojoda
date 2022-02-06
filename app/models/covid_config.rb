class CovidConfig < ApplicationRecord
      
      resourcify
      audited
  belongs_to :fund

  def show_options
    ([self.normal, self.due_date, self.payment_agreement, self.custom_adjustment, self.no_payment].compact.uniq - ['No Ofrecer']).count > 0
  end

  
end
