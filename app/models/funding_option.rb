
class FundingOption < ApplicationRecord
  include LumniModeling
  include LumniFinance
      
    resourcify
    audited
    belongs_to :modeling_fixed_condition
    belongs_to :application, touch: true
	# has_many :funding_option_status, dependent: :destroy
	has_many :funding_option_config, dependent: :destroy
	has_one :nominal_payment_record, -> {where(name: 'nominal_payment')}, class_name: 'FundingOptionConfig', foreign_key: 'funding_option_id'
	has_many :invalid_disbursements,->{where('student_value <= 0')}, class_name: 'Disbursement', foreign_key: 'funding_option_id'
	has_many :funding_option_disbursement, dependent: :destroy
	has_many :disbursement,->{where('student_value > 0').order(:forcasted_date)}, through: :funding_option_disbursement, class_name: 'Disbursement'
	has_many :disbursement_cancellation, through: :disbursement, source: :disbursement_cancellation
	has_many :original_disbursement, class_name: 'Disbursement', foreign_key: 'funding_option_id',dependent: :destroy
	has_many :modeling_match, as: :resource , dependent: :destroy
	has_one :isa, dependent: :destroy
	has_many :legal_match, as: :resource , dependent: :destroy
	has_many :investment_decision, dependent: :destroy
	has_many :modeling_flow, dependent: :destroy
	has_many :modeling_sencibility_detail, dependent: :destroy
	has_many :tuition_disbursements, -> {where(disbursement_case: "tuition")}, through: :funding_option_disbursement, source: :disbursement

	has_many :active_disbursements, -> {where.not(status: 'canceled')}, through: :funding_option_disbursement, source: :disbursement

	# Just for estimating disbursement total payment (start)
	has_many :payed_disbursements, -> {where(disbursement_case: ['tuition','living_expenses'],status: 'payed')}, through: :funding_option_disbursement, source: :disbursement
	has_many :non_payed_disbursements, -> {where(disbursement_case: ['tuition','living_expenses'],status: ['generated','requesting','active'])}, through: :funding_option_disbursement, source: :disbursement
	has_many :approved_disbursements, -> {where(disbursement_case: ['tuition','living_expenses'],status: 'approved')}, through: :funding_option_disbursement, source: :disbursement
	# Just for estimating disbursement total payment (end)

	has_many :disbursement_payment, through: :disbursement
	has_many :disbursement_match, through: :disbursement
	has_many :payment_match,->{joins(:payment).where('payments.resource_type != ?','PaymentAgreement').distinct}, through: :isa, source: :document_payment_match
	
	scope :funding_options_with_dynamic_rate, -> { joins(:funding_option_config).where(funding_option_configs: {name: 'dynamic_rate_cap', other_value: 'true'})}
	scope :by_country, -> (country){ joins(:funding_option_config).where(funding_option_configs: {name: 'country', other_value: country})}
	
	belongs_to :original_option, class_name: 'FundingOption', foreign_key: 'original_option_id', optional: true

	before_save :set_external_id
	before_save :validate_model_result
	before_save :setting_cache_variables
	before_save :validate_duplicates
	after_touch :touch_cache_variables
	after_touch :update_cap_value
	after_commit :update_cap_value, on: [:create,:update]


	def validate_duplicates
		conflict_options = FundingOption.includes(:nominal_payment_record).where({ application_id: self.application_id, percentage_graduated: self.percentage_graduated, percentage_student: self.percentage_student, isa_term: self.isa_term, model_status: 'done'}).where.not(id: self.id)
		if self.model_status == 'done' && self.isa.nil? && conflict_options.any?
			current_nominal_payment = self.nominal_payment_record.value
			conflict_options.each do |conflict|
				if conflict.nominal_payment_record.value == current_nominal_payment
					self.model_status = 'failed'
				end
			end
		end
	end


	def fast_destroy
      PerformServiceAsync.perform_async('DestroyFundingOptionService', self.id)
	end

	def update_cap_value
		if Rails.env == 'production'
			ValueToCapAsync.perform_async(self.id, Time.now.to_date)
		else
			UpdateValueToCapService.for(self, Time.now.to_date)
		end
	end
		
	def top_rate_cap
		return false unless self.isa.present?
		self.isa.funding_opportunity.payment_config.top_rate_cap
	end


	def setting_cache_variables
		self.total_pending_disbursement = total_pending_disbursement_logic
		self.total_payed_disbursement = total_payed_disbursement_logic
		self.total_approved_disbursement = total_approved_disbursement_logic
	end

	def touch_cache_variables
		self.update_column('total_pending_disbursement', self.total_pending_disbursement_logic)
		self.update_column('total_payed_disbursement', self.total_payed_disbursement_logic)
		self.update_column('total_approved_disbursement', self.total_approved_disbursement_logic)
	end


	def isa_extrapayments
		PaymentMatch.joins(:isa).where('isas.funding_option_id = ?',self.id).distinct
	end

	def isa_total_payments
		Payment.joins(billing_document: :isa).where('isas.funding_option_id = ?',self.id)
	end
	

	def student_flow
		disbursements = self.disbursement_payment.includes(:disbursement).where(status: 'payed',disbursements: {disbursement_case: ['living_expenses','tuition']})
		payments = self.payment_match.includes(:payment)
		extra_payments = self.isa_extrapayments.includes(:payment)

		flow_hash = {}

		if self.nominal_cap.present?
			cum_date_values flow_hash, self.nominal_cap, Time.zone.now
		else
			disbursements.each do |disbursement|
				target_date = disbursement.modeling_date
				disbursement_value = disbursement.disbursement.adjusted_student_value - disbursement.disbursement.canceled
				cum_date_values flow_hash, disbursement_value, target_date.to_date.beginning_of_month
			end
		end

		payments.each do |payment|
			cum_date_values flow_hash, payment.value, payment.payment.payment_date.to_date.beginning_of_month, negative: true
		end

		extra_payments.each do |payment|
			cum_date_values flow_hash, payment.value, payment.payment.payment_date.to_date.beginning_of_month, negative: true
		end

		flow_hash
	end

	def student_flow_for_xirr
		disbursements = self.disbursement_payment.includes(:disbursement).where(status: 'payed',disbursements: {disbursement_case: ['living_expenses','tuition']})
		payments = self.payment_match.includes(:payment)
		extra_payments = self.isa_extrapayments.includes(:payment)

		flow_hash = {}

		disbursements.each do |disbursement|
			target_date = disbursement.modeling_date
			disbursement_value = disbursement.disbursement.adjusted_student_value - disbursement.disbursement.canceled
			cum_date_values flow_hash, disbursement_value, target_date.to_date.beginning_of_month
		end

		payments.each do |payment|
			if ['penalty'].exclude?(payment.target_record.detail_case)
				cum_date_values flow_hash, payment.value, payment.payment.payment_date.to_date.beginning_of_month, negative: true
			end
		end

		extra_payments.each do |payment|
			cum_date_values flow_hash, payment.value, payment.payment.payment_date.to_date.beginning_of_month, negative: true
		end
		flow_hash
	end

	def student_xirr_logic
		target_hash = self.student_flow_for_xirr
		lumni_xirr(target_hash)
	end

	def update_xirr
		self.update_column('xirr', self.student_xirr_logic)
	end


	def xnpv_student_flow
		lumni_xnpv self.student_flow, self.decimal_rate_cap
	end


	def payment_excess_flow
		min_date = self.student_flow.keys.min
		payment_excess = self.user.payment_excess.includes([:payment])

		flow_hash = {}
		flow_hash[min_date] = 0
		payment_excess.each do |payment|
			cum_date_values flow_hash, payment.value, payment.payment.payment_date.to_date.beginning_of_month, negative: true
		end
		flow_hash
	end


	def xnpv_payment_excess
		lumni_xnpv self.payment_excess_flow, self.decimal_rate_cap
	end

	def value_to_cap_with_excess_logic evaluation_date
		result = nil
		if self.decimal_rate_cap.present?
			if student_flow.any?
				result = self.value_to_cap + lumni_future_value(self.xnpv_payment_excess, self.monthly_decimal_rate_cap, payment_excess_flow.keys.min, evaluation_date.to_date.beginning_of_month)
			end
		end

		if self.nominal_cap.present?
			if student_flow.any?
				result = self.value_to_cap + self.xnpv_payment_excess
			end
		end

		return result
	end


	def exporting_cashflow_hash
		disbursements = self.disbursement_payment.includes(:disbursement).where(status: 'payed',disbursements: {disbursement_case: ['living_expenses','tuition']})
		payments = self.payment_match.includes(:payment)
		extra_payments = self.isa_extrapayments.includes(:payment)
		raw_payments = self.isa_total_payments

		cashflow_hash = {}

		disbursements.each do |disbursement|
			target_date = disbursement.modeling_date
			disbursement_value = disbursement.value - disbursement.disbursement.canceled
			create_cashflow_hash cashflow_hash, 'disbursement', target_date.to_date.beginning_of_month, disbursement_value
		end

		payments.each do |payment|
			create_cashflow_hash cashflow_hash, 'payment', payment.payment.payment_date.to_date.beginning_of_month, payment.value
		end

		extra_payments.each do |payment|
			create_cashflow_hash cashflow_hash, 'extra_payments', payment.payment.payment_date.to_date.beginning_of_month, payment.value
		end

		raw_payments.each do |payment|
			create_cashflow_hash cashflow_hash, 'raw_payments', payment.payment_date.to_date.beginning_of_month, payment.value
		end

		cashflow_hash
	end

	def exporting_cashflow_array
		cashflow = self.exporting_cashflow_hash
		target_date = cashflow.keys.min
		cashflow_array = [['date','disbursement','payment','extra_payment','raw_payments']]
		while target_date <= Time.now.to_date.beginning_of_month
			row = cashflow[target_date]
			if row.nil?
				cashflow_array << [target_date.to_s,0,0,0,0]
			else
				cashflow_array << [target_date.to_s,row['disbursement'].to_f,row['payment'].to_f,row['extra_payments'].to_f,row['raw_payments']]
			end
			target_date = (target_date + 1.month).beginning_of_month
		end
		cashflow_array
	end


	def create_cashflow_hash target_hash, target_column, target_date, target_value
		if target_hash[target_date].nil?
			target_hash[target_date] = {}
		end
		target_hash[target_date][target_column] = target_hash[target_date][target_column].to_f + target_value
	end


	def value_to_cap_logic evaluation_date
		if self.decimal_rate_cap.present?
			if self.student_flow.size > 0
				begin
					@result = (self.xnpv_student_flow*(1 + self.monthly_decimal_rate_cap)**months_between(student_flow.keys.min,evaluation_date.to_date.beginning_of_month)).floor(2).to_f
				rescue Exception => e
					@result = I18n.t('isa.cap_calculation_fail')
				end
			else
				@result = 0
			end
		end
		
		if self.nominal_cap.present?
			if self.student_flow.any?
				@result = self.xnpv_student_flow
			end
		end

		@result
	end

	def cum_date_values target_hash, target_value, target_date, options = {}
		if options[:negative]
			target_value = target_hash[target_date].to_f - target_value.to_f
		else
			target_value = target_hash[target_date].to_f + target_value.to_f
		end
		target_hash[target_date] = target_value
	end

	def restore_to_model
		#It is different to restore all disbursements than to restore only the disbursements created with this funding option. The funding option could be an amendment with fixed disbursements from another funding option.
		# Never change the following line to self.disbursement
		disbursements = Disbursement.where(funding_option_id: self.id)
		disbursements.each do |disbursement|
			disbursement.student_value = disbursement.revisions.first.student_value
			disbursement.company_value = disbursement.revisions.first.company_value
			disbursement.save
		end
		self.percentage_student = self.revisions.first.percentage_student
		self.percentage_graduated = self.revisions.first.percentage_graduated
		self.isa_term = self.revisions.first.isa_term
		self.save
	end

	def validate_model_result
		if self.model_status == 'failed'
			self.visible_to_student = false
		end
	end

	def set_external_id
		self.external_id = Digest::MD5.hexdigest("funding_option_#{self.id}_#{self.created_at}")
	end

	def right_application
		a = self.application
		a.original_application_id.present? ? a.original_application : a
	end

	def model_with_r valuation_history_id=nil
		target_info = self.get_adjusted_modeling_data
		modeling_info = self.target_research_process.run_research_process target_info
		store_modeling_info(modeling_info, valuation_history_id)
	end

	def get_adjusted_modeling_data
		modeling = self.modeling
		if self.application.user.modeling_variable.count == 0
			program_id = self.right_application.funded_major.id
			options = {program_id: program_id}
			assign_modeling_variables user, options
		end


		target_info = self.info_hash_for_r


		if self.application.user.modeling_variable.count == 0 
			dropout_keys = target_info['modeling_variables'].map{|info| info[:acronym]}.select{|acronym| acronym.include?('desercion_periodo')}
			target_info['modeling_variables'].select{|info| info[:acronym] == 'default'}.first['value'] += modeling.delta_default.to_f / 100
			target_info['modeling_variables'].select{|info| info[:acronym] == 'desempleo'}.first['value'] += modeling.delta_unemployment.to_f / 100
			delta_dropout = modeling.delta_dropout.to_f / (100 *dropout_keys.size.to_i)
			dropout_keys.each do |drop_key|
				target_info['modeling_variables'].select{|info| info[:acronym] == drop_key}.first['value'] += delta_dropout
			end
		end

		return target_info
	end

	def info_hash_for_r
		target_params = {}
		target_params['fund'] = [self.fund.attributes]
		target_params['payment_config'] = [self.funding_opportunity.payment_config.attributes]
		target_params['funding_opportunity'] = [self.funding_opportunity.attributes]
		target_params['modeling'] = [self.modeling.attributes]
		target_params['modeling_fixed_condition'] = [self.modeling_fixed_condition.attributes]
		target_params['funding_option'] = [self.attributes]
		target_params['funding_option_config'] = self.funding_option_config.map{|f| f.attributes}
		target_params['disbursement'] = self.disbursement_info
		target_params['modeling_variables'] = self.user.modeling_variables_hash
		target_params['funded_major'] = [self.right_application.funded_major.attributes]
		target_params['process_info'] = self.process_info
		target_params['country'] = [self.country.attributes]
		target_params['user'] = [self.user.attributes]
		target_params['inflation_info'] = self.inflation_info.map{|i| i.attributes}
		target_params['modeling_fee'] = self.fees_info
		target_params['disbursement_payment'] = [self.disbursement_payment.map{|i| i.attributes}]
		target_params['student_academic_information'] = [self.right_application.funded_major.attributes]
		target_params['gateway'] = [self.right_application.funding_opportunity.fund.payment_gateway.attributes]
		target_params['default_matrix'] = [self.right_application.funding_opportunity.fund.company.country.default_matrix.map{|i| i.attributes}]
		target_params['funding_option_disbursement'] = self.funding_option_disbursement.map{|i| i.attributes}


		if !self.isa.nil?
			target_params['isa'] = [self.isa.attributes]
			target_params['payments'] = self.isa.payments_to_isa.map{|p| p.attributes}
			target_params['payment_agreement'] = self.isa.active_payment_agreements.map{|a| a.attributes}
			target_params['billing_document_details'] = self.isa.billing_document_detail.joins(:billing_document_match).map{|i| i.attributes}
			target_params['isa_status'] = self.isa.isa_status.map{|i| i.attributes}
		elsif self.application.remodeling?
			target_params['payments'] = self.application.resource.payments_to_isa.map{|p| p.attributes}
			target_params['payment_agreement'] = self.application.resource.active_payment_agreements.map{|a| a.attributes}
			target_params['billing_document_details'] = self.application.resource.billing_document_detail.joins(:billing_document_match).map{|i| i.attributes}
			target_params['isa_status'] = self.application.resource.isa_status.map{|i| i.attributes}
		end

		return target_params
	end

	def number_repayments_payed
		result = 0
		if !self.isa.nil?
			result = self.isa.repayment_payed_number_logic
		end
		return result
	end

	def disbursement_info
		schoolarship_type = self.fund.cancellation_config.where(record_type: 'Beca').pluck(:cancellation_type).uniq

    schoolarship_type += ['tuition'] unless self.fund.include_tuition_in_modeling

		self.disbursement.where(disbursement_case: ['tuition','living_expenses']).where.not(status: "canceled").map do |d| 
      d.attributes.merge({	
				'cancellantion_scholarship'=> target_cancellation(d, schoolarship_type),
				'non_scholarship_cancelation'=> d.non_scholarship_cancelation
			})
    end
	end
	

	def target_cancellation(disbursement, schoolarship_type)
		result = 	if schoolarship_type.include?(disbursement.disbursement_case)
								disbursement.student_value
							else
								disbursement.cancellantion_scholarship
							end

		return result
	end

	def active_for_collection
		if self.isa.nil?
			result = true
		else
			result = self.isa.active_for_collection?
		end
		return result
	end



	def discretionary_forbearance_total_months
		result = 0
		if !self.isa.nil?
			result = self.isa.isa_status.where(status: 'discretionary_forbearance').map{|s| months_between( s.start_date, s.end_date)}.compact.inject(:+).to_i
		end
		return result
	end

	def inflation_info
		self.country.ipc.where(month: 12)
	end


	def modeling
		self.modeling_fixed_condition.modeling
	end

	def target_research_process
		self.right_application.funding_opportunity.modeling.research_process
	end

	def async_model_with_r
		ModelClassesAsync.perform_async('FundingOption', 'model_with_r', self.id)
	end

	def user
		self.right_application.user
	end

	def funding_opportunity
		self.right_application.direct_funding_opportunity
	end

	def fund
		self.funding_opportunity.fund
	end

	def company
		self.fund.company
	end

	def country
		self.company.country
	end


	def process_info
		hash_process_info = [{
					'repayment_start_date'=> self.start_repayment_date.beginning_of_month,
					'current_income'=> self.user.total_income,
					'discretionary_forbearance_total_months'=> self.discretionary_forbearance_total_months,
					'number_repayments_payed'=>self.number_repayments_payed,
					'active_for_collection'=> self.active_for_collection,
					'inflation_adjustment_date' => self.inflation_adjustment_date
				}]
	end

	def inflation_adjustment_date
		first_disbursement_date = self.disbursement.minimum(:forcasted_date)
		isa = self.isa
		if isa.nil? && self.original_option.present? && self.original_option.isa.present?
			isa = self.original_option.isa
		end

		if isa.present?
			result = [isa.inflation_adjustment_date, first_disbursement_date].max
		else
			result = first_disbursement_date
		end
		return result
	end



	def fees_info
		fees_hash = []
		modeling = self.modeling

		modeling.modeling_fee.to_model.each do |fee|
			puts fee.id
			fees_hash += [{"fees"=>"json", 
						"fees_id"=>fee.id, 
						"fee_name"=>fee.fee_name, 
						"comisión"=>fee.fee_case, 
						"r_type_fixed"=>fee.r_type_fixed, 
						"fee_peridicity"=>fee.fee_peridicity, 
						"fee_included_taxes"=>fee.fee_included_taxes, 
						"fee_inflation_adjustment"=>fee.fee_inflation_adjustment, 
						"fee_iva"=>fee.fee_iva, 
						"fee_who_pay"=>fee.fee_who_pay, 
						"fee_target"=>fee.fee_target, 
						"fee_fixed_part"=>fee.fee_fixed_part, 
						"fee_variable_part"=>fee.fee_variable_part, 
						"Fee_CP__c"=>fee.fee_cp, 
						"Fee_RP__c"=>fee.fee_rp, 
						"Percentaje_fee_CP__c"=>fee.percentaje_fee_cp, 
						"Percentaje_fee_RP__c"=>fee.percentaje_fee_rp, 
						"value_fee_start_fee_field"=>fee.start_date(self), 
						"value_fee_end_fee_field"=>fee.end_date(self), 
						"value_fee_unique_date_field"=> fee.unique_date_value(self), 
						"value_fee_variable_part_field"=>fee.value_fee_variable_part_field, 
						"fee_fixed_adjustment"=>0, 
						"fee_another_tax"=>fee.fee_another_tax,
						"fee_case"=> fee.value_fee_start_fee_field}]
		end
		return fees_hash
	end

	def disbursements_info
		disbursements_hash =[]
		disbursements = self.disbursement
		disbursements.each do |disbursement|
			disbursement_case = nil
			case disbursement.disbursement_case
			when 'academic_bonus'
				disbursement_case = 'Bono Académico'
			when 'tuition'
				disbursement_case = 'Matrícula'
			when 'living_expenses'
				disbursement_case = 'Manutención'
			end

			disbursements_hash += [{"disbursements"=>"json", 
				"disbursement_id"=>disbursement.id, 
				"disbursement_contract"=>disbursement.funding_option_id, 
				"disbursement_status"=>"Generado", 
				"disbursement_date"=>disbursement.forcasted_date, 
				"disbursement_cancellation_by_scholarship"=>0, 
				"disbursement_forcasted"=>disbursement.student_value, 
				"r_type_fixed"=>disbursement_case, 
				"disbursement_real"=>disbursement.company_value, 
				"disbursement_condonation"=>0}]
		end
		return disbursements_hash
	end

	def fund_info
		fund_hash = [{"fund"=>"json", 
			"fund_id"=>self.fund.id, 
			"main_fund"=>self.fund.fund_id, 
			"fund_country"=>self.fund.company.country.id, 
			"Hurdle__c"=>"false", 
			"R_Hurdle__c"=>0.1}]
		return fund_hash
	end

	def payment_info
		payments_hash = []
		if !self.isa.nil?
			payments = self.isa.payments
			payments.each do |payment|
				payments_hash += [{"payments"=>"Formato", 
					"payment_account"=>self.id, 
					"paymet_contract"=>self.isa.id, 
					"Payment_document"=>payment.billing_document_id, 
					"Disbursement_request"=>"", 
					"payment_fund"=>self.fund.id, 
					"payment_id"=>payment.id, 
					"payment_date"=>payment.payment_date, 
					"payment_value"=>payment.value}]
			end
		end
		return payments_hash
	end



	def first_disbursement_date
		result = nil
		if self.isa.nil?
			disbursements = self.disbursement.order(forcasted_date: :asc)
			if disbursements.count  > 0
				result = disbursement.pluck(:forcasted_date).min
			end
		else
			disbursement_request = DisbursementRequest.joins(:disbursement_payment,:application).
				where(applications: {resource_type: 'Disbursement', resource_id: self.disbursement.ids}).
				where(disbursement_payments: {status: 'payed'}).
				order(due_date: :asc).first

			if !disbursement_request.nil? && disbursement_request.due_date.present?
				result = disbursement_request.due_date
			else
				result = self.disbursement.minimum(:forcasted_date)
			end
		end
		return result
	end

	def activation_date
		if self.isa.nil?
			result = Time.now.to_date
		else
			result = self.isa.activation_date
		end
		return result
	end

	def theoretical_graduation_date
		temp_theoretical_date = self.disbursement.maximum(:forcasted_date) + self.right_application.funded_major.disbursements_periodicity.to_i.months
		temp_graduation_date = self.right_application.funded_major.graduation_date.nil? ? self.right_application.funded_major.expected_graduation_date : self.right_application.funded_major.graduation_date
		if temp_graduation_date.present?
			result = [temp_theoretical_date, temp_graduation_date].max
		else 
			result = temp_theoretical_date
		end
		return result
	end

	def start_repayment_date
		result = nil
		if self.isa.present?
			billing_documents = self.isa.billing_document_detail.where(detail_case: "repayment").order(reference_date: :desc)
			if billing_documents.count > 0
				result = billing_documents.last.reference_date
			end
		end

		if self.disbursement.count > 0
			theoretical_date = self.theoretical_graduation_date + self.grace_period_allowed.to_i.months

			if result.nil?
				result = theoretical_date
			elsif result.present? && self.isa.present?
				result = [result, theoretical_date + self.isa_term.to_i.months].min
			end
		end
		return result
	end

	def regular_exit_from_fond_date
		if self.isa.nil? || self.isa.fund_regular_exit_date.nil?
			result = self.disbursement.pluck(:forcasted_date).max.to_date + 
				(self.user.funded_academic_information.disbursements_periodicity.to_i +
				self.grace_period_allowed.to_i +
				self.unemployment_allowed.to_i +
				self.isa_term.to_i).months
		else
			result = self.isa.fund_regular_exit_date
		end
		return result
	end

	def selection_test_date
		selection_test = self.right_application.user_questionnaire.joins(:questionnaire).where(questionnaires: {category: "selection_test"}).first
		if !selection_test.nil?
			result = selection_test.updated_at
		else
			result = nil
		end
		return result
	end

	def get_funded_config target_status
		temp = self.funding_option_config.find_by(name: target_status)
		if !temp.nil?
			@result = temp.value.nil? ? temp.max_months : temp.value
		end
		return @result
	end

	def total_pending_disbursement_logic
		self.non_payed_disbursements.sum(:student_value).to_f
	end

	def total_payed_disbursement_logic
		DisbursementPayment.joins(disbursement: :funding_option_disbursement).where('funding_option_disbursements.funding_option_id = ? AND disbursement_payments.status = ?',self.id, 'payed').sum(:value)
	end

	def total_approved_disbursement_logic
		DisbursementMatch.joins(disbursement: :funding_option_disbursement).where('funding_option_disbursements.funding_option_id = ? AND disbursements.status != ?',self.id, 'canceled').sum(:values)
	end

	def approved_not_disbursed
		[self.total_approved_disbursement.to_f - self.total_payed_disbursement.to_f,0].max
	end


	def funded_student_amount
		self.total_pending_disbursement.to_f + self.total_payed_disbursement.to_f + self.approved_not_disbursed.to_f
	end

	def unemployment_allowed
		self.get_funded_config('unemployment_months')
	end

	def grace_period_allowed
		self.get_funded_config('grace_period')
	end

	def threshold_allowed
		self.get_funded_config('threshold')
	end

	def nominal_payment_allowed
		self.get_funded_config('nominal_payment')
	end

	def cap
		self.funding_option_config.where(name: ['rate_cap','nominal_cap','salary_cap']).map{|f| [f.name,f.value]}
	end

	def decimal_rate_cap
		rate_record = self.funding_option_config.find_by(name: 'rate_cap')
		if rate_record.present?
			@result = rate_record.value.to_d / 100
		end
	end

	def monthly_decimal_rate_cap
		(1 + self.decimal_rate_cap.to_d)**(1/12.to_d) -1 if self.decimal_rate_cap.present?
	end

	def self.visible
		self.where(visible_to_student: true)
	end

	def self.selected
		self.joins(:modeling_match).where(modeling_matches: {status: "selected"})
	end

	def self.selected?
		self.selected.size > 0
	end

	def selected?
		self.modeling_match.where(modeling_matches: {status: "selected"}).size > 0
	end

	def nominal_cap
		rate_record = self.funding_option_config.find_by(name: 'nominal_cap')

		if rate_record.present?
			@result = rate_record.value
		end
	end


	def real_funded_amount_today
		total_payed_disbursement.to_f - payed_by_student_without_university_payments.to_f - payed_academic_bonus_disbursement.to_f
	end


	def payed_by_student
		payments = self.payed_disbursements.map(&:payed_by_student).compact.inject(:+)
	end

	def payed_by_student_without_university_payments
		payments = self.payed_disbursements
						.joins(:disbursement_request)
						.where.not(disbursement_requests: { payment_target: payment_to_university })
						.map(&:payed_by_student).compact.inject(:+)
	end

	def payed_academic_bonus_disbursement
		self.disbursement.select{|d| d.disbursement_case == 'academic_bonus'}.select{|d| d.status == 'payed'}.pluck(:disbursed).reduce(:+)
	end


	def payment_to_university
		'Consignación a la cuenta de  la universidad'
	end

	def disbursement_not_canceled
		self.disbursement.where.not(status: 'canceled')
	end

	def disbursement_not_canceled_nor_academic_bonus
		self.disbursement_not_canceled.where.not(disbursement_case: 'academic_bonus')
	end

end
