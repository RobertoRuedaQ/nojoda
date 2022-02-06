class ConciliationInformation < ApplicationRecord
      include LumniFinance
      
      resourcify
      audited
      belongs_to :isa
      belongs_to :payment_agreement, optional: true
      belongs_to :income_information
      has_one :payment, as: :resource
      has_one :application, as: :resource


      has_one_attached :annual_income_support

      def income_full_name
            if self.income_information.present?
                  self.income_information.full_name
            end
      end

      def application_id
            application.id
      end


      def funding_opportunity
      	self.isa.funding_opportunity
      end

      def origination
      	self.funding_opportunity.fund.conciliation_origination
      end


      def expected_payment_value
            begin
                  self.isa.funding_option.percentage_graduated / 100 * self.total_income.to_f * self.expected_months / (months_between(self.start_date,self.end_date) + 1).to_f
            rescue Exception => e
                  
            end
      end

      def difference_value
            begin
                  (self.expected_payment_value - self.total_payment_value).round
            rescue Exception => e
                  
            end
      end

      def total_payment_value
            begin
                  self.isa.total_payment_by_year_for_conciliation(self.start_date, self.end_date)
            rescue Exception => e
                  
            end
      end


      def expected_months
            # Adjust by income information start date (done by adjusting the period + 1).
            # Generate conciliation from SM persective (done).
            # Create a conciliation summary view (done).
            # Adjust period from February to January.(done)
            # Add check to add conciliation process by fund (done).
            # Automatice notification.
            if self.end_date.present?

                  isa = self.isa
                  graduation_date = isa.student_academic_information.graduation_date
                  if graduation_date.present? && graduation_date < self.end_date
                    start_date = [self.start_date, graduation_date].max
                    @target_months = 1 + months_between(start_date, self.end_date)
                  end
            end
            @target_months.to_i
      end



end
