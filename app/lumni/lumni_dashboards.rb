module LumniDashboards
  def payu_payments params
		if params[:payu_response].present?
			target_ids = params[:payu_response][:target_ids].to_s.gsub("\n",",").gsub("\r","").split(',')
			if target_ids.size > 0
				@payu_responses = PayuResponse.includes(payu_transaction: [billing_document: [isa: [funding_opportunity: :fund]]]).includes(payu_transaction: [billing_document: [isa: :user]]).where(transaction_id: target_ids).distinct

				@responses_template = {}
				@responses_template[:id] = {}
				@responses_template[:user_name] = {}
				@responses_template[:user_identification_number] = {}
				@responses_template[:value] = {}
				@responses_template[:fund_name] = {}
				@responses_template[:created_at] = {}
				@responses_template = @responses_template.merge(current_user.template('PayuResponse','payu_responses',current_user,id: true))
			end
    end
  end
  
  
  def payment_mass_manager params
    if params[:payment_mass_detail].nil?
      @start_date = Time.now.beginning_of_month.to_date
      @end_date = Time.now.end_of_month.to_date
      @status = ['pending_match']
    else
      @start_date = params[:payment_mass_detail][:start_date].nil? ? Time.now.beginning_of_month.to_date : params[:payment_mass_detail][:start_date]
      @end_date = params[:payment_mass_detail][:end_date].nil? ? Time.now.end_of_month.to_date : params[:payment_mass_detail][:end_date]
      @status = params[:payment_mass_detail][:status].nil? ? ['pending_match'] : params[:payment_mass_detail][:status]
    end

    @payment_mass_detail = PaymentMassDetail.
      includes(:payment_mass, :payment_mass_doc).
      where(payment_masses: {company_id: current_company.my_companies.ids}).
      where('payment_mass_details.transaction_date >= ? AND payment_mass_details.transaction_date <= ? AND payment_mass_details.status IN (?)',@start_date,@end_date,@status).kept
  end

  def billing_document_dashboard params
    @billing_document_fund_list = FormList.find(25).get_list( current_user, current_company)
    if params[:billing_document].nil?
      @start_date = Time.now.beginning_of_month.to_date
      @end_date = Time.now.end_of_month.to_date
      @funds = [@billing_document_fund_list[:funds][:values].first]
    else
      @start_date = params[:billing_document][:start_date].nil? ? Time.now.beginning_of_month.to_date : params[:billing_document][:start_date]
      @end_date = params[:billing_document][:end_date].nil? ? Time.now.end_of_month.to_date : params[:billing_document][:end_date]
      @funds = params[:billing_document][:funds].nil? ? [@billing_document_fund_list[:funds][:values].first] : params[:billing_document][:funds]
    end

    @start_date = @start_date.to_date.beginning_of_month
    @end_date = @end_date.to_date.beginning_of_month

    billing_document_ids = BillingDocument.select(:id).joins({isa: :funding_opportunity}).where("billing_documents.reference_date >= ? AND billing_documents.reference_date <= ? AND funding_opportunities.fund_id IN (?)",@start_date,@end_date,@funds).ids.uniq
    @billing_documents = BillingDocument.includes({isa: :user}).where(id: billing_document_ids)

  end

  def covid_dashboard params
    @covid_fund_list = FormList.find(25).get_list( current_user, current_company)
    if params[:covid].nil?
      @start_date = Time.now.to_date
      @end_date = Time.now.to_date
      @funds = [@covid_fund_list[:funds][:values].first]
    else
      @start_date = params[:covid][:start_date].nil? ? Time.now.to_date : params[:covid][:start_date]
      @end_date = params[:covid][:end_date].nil? ? Time.now.to_date : params[:covid][:end_date]
      @funds = params[:covid][:funds].nil? ? [@covid_fund_list[:funds][:values].first] : params[:covid][:funds]
    end

    covid_ids = CovidEmergency.select(:id).joins({billing_document: [{isa: :funding_opportunity}]}).where('covid_emergencies.created_at >= ? AND covid_emergencies.created_at <= ? AND funding_opportunities.fund_id IN (?)',@start_date,@end_date,@funds).ids.uniq
    @covid = CovidEmergency.includes({billing_document: [{isa: :user}]}).where(id: covid_ids)

  end

  def legacy_status_dashboard params
    status_3 = legacy_status_3[:options][:values]
    status_4 = legacy_status_4[:options][:values]

    @status_array = []
    @status_hash = {}
    @fields = {}

    status_3.each_with_index do |field_3,index|
      field_4 = status_4[index]
      @fields[field_3] = field_4
      if index == 0
        @status_array << Isa.joins(funding_opportunity: :fund).joins(user: :legacy_status).joins(:student_academic_information).where('funds.company_id IN (?)',current_company.my_companies.ids).group("legacy_statuses.#{field_3}","student_academic_informations.#{field_4}").size
      else
        @status_array << Isa.joins(funding_opportunity: :fund,user: :legacy_status).where('funds.company_id IN (?)',current_company.my_companies.ids).group("legacy_statuses.#{field_3}","isas.#{field_4}").size
      end
      @status_hash[field_3] = {}
      @status_array[index].each_with_index do |values,i|
        names, number = values
        if @status_hash[field_3][names.first].nil?
          @status_hash[field_3][names.first] = {}
        end
        @status_hash[field_3][names.first][names.second] = number
      end
    end
  end

  def status_table_dashboard params
    if params[:legacy_field].present? && params[:isa_field].present? && params[:legacy_value].present? && params[:isa_value].present?
      if params[:isa_field] != 'stored_academic_information'
        isa_ids = Isa.distinct.joins(funding_opportunity: :fund,user: [:legacy_status]).
        where("legacy_statuses.#{params[:legacy_field]} = ? AND isas.#{params[:isa_field]} = ?",params[:legacy_value],params[:isa_value]).
        where('funds.company_id IN (?)' ,current_company.my_companies.ids)
      else
        isa_ids = Isa.distinct.joins(:student_academic_information,user: :legacy_status,funding_opportunity: :fund).
        where("legacy_statuses.#{params[:legacy_field]} = ? AND student_academic_informations.#{params[:isa_field]} = ?",params[:legacy_value],params[:isa_value]).
        where('funds.company_id IN (?)' ,current_company.my_companies.ids)
      end
      @isas = Isa.includes(user: :legacy_status,funding_opportunity: :fund).where(id: isa_ids)
    else

    end
  end

  def disbursement_dasboard(params)
    @start_date = params[:disbursement_dasboard].present? ? params[:disbursement_dasboard][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:disbursement_dasboard].present? ? params[:disbursement_dasboard][:end_date] : [Time.now.beginning_of_month.to_date]

    @disbursement_data = Application
      .includes(:resource, {disbursement_request: [:disbursement_match, :disbursement_payment]}, user: [{reporting_to: :supervisor}, :contact_info,:bank_account, {funded_programs: [{institution: :bank_account}]}, :personal_information,isa: {funding_option:{application: {funding_opportunity_from_resource: :fund}}}])
      .where(applications: { resource_type: "Disbursement", application_case: "disbursement_request"})
      .where('created_at BETWEEN ? AND ?', @start_date, @end_date)
      .distinct
  end

  def applications_dashboard(params)
		@funding_opportunity_list = FormList.all_funding_opportunities_list(current_company)
		@funding_opportunities = params[:applications_dashboard].present? ? params[:applications_dashboard][:funding_opportunity] : [@funding_opportunity_list[:options][:values].first]
    @start_date = params[:applications_dashboard].present? ? params[:applications_dashboard][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:applications_dashboard].present? ? params[:applications_dashboard][:end_date] : [Time.now.beginning_of_month.to_date]
    @applications_data = User
      .joins(:application)
      .includes({funding_opportunity_applications:[:application_committee, funding_opportunity_from_resource: [:fund]] },:contact_info, {user_questionnaire: [:questionnaire, :user_questionnaire_score, :questionnaire_exception]}, {reporting_to: :supervisor},:personal_information,{location: [:city]}, {funded_programs: [:major, :institution]} )
      .where(applications: { resource_type: "FundingOpportunity", resource_id: @funding_opportunities})
      .where('applications.created_at BETWEEN ? AND ?', @start_date, @end_date)
  end
  

  def disbursements_paid_in_the_month(params)
    @start_date = params[:disbursements_paid_in_the_month].present? ? params[:disbursements_paid_in_the_month][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:disbursements_paid_in_the_month].present? ? params[:disbursements_paid_in_the_month][:end_date] : [Time.now.beginning_of_month.to_date]

    @disbursements_paid = DisbursementPayment
      .includes(:disbursement_request, {disbursement: [{student_academic_information: :institution}, {isa: [:user, {funding_opportunity: :fund}, :funding_option]}] })
      .where('created_at BETWEEN ? AND ?', @start_date, @end_date)
  end

  def scoring_dashboard(params)
    @funding_opportunity_list = FormList.all_funding_opportunities_list(current_company)
    @funding_opportunities = params[:scoring_dashboard].present? ? params[:scoring_dashboard][:funding_opportunity] : [@funding_opportunity_list[:options][:values].first]
  
    @scoring_info = User
      .joins(:funding_opportunity_applications)
      .includes(:reference,:student_financial_information,:active_income_information,:child,{funding_opportunity_applications:[:application_committee, funding_opportunity_from_resource: [:fund]] },:sociodemographic,:student_debt ,:contact_info, {user_questionnaire: :questionnaire}, {reporting_to: :supervisor},:personal_information,{location: [:city]}, {funded_programs: [:major, :institution, :university_info]} )
      .where(applications: { resource_type: "FundingOpportunity", resource_id: @funding_opportunities})
  end

  def billing_document_dashboard(params)
    @start_date = params[:billing_document].present? ? params[:billing_document][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:billing_document].present? ? params[:billing_document][:end_date] : [Time.now.beginning_of_month.to_date]
    
    @billing_document_data = BillingDocument
    .includes([:billing_document_detail,{isa: [:user, {funding_opportunity: :fund}]}])
    .where('billing_documents.due_to_date BETWEEN ? AND ?', @start_date, @end_date)
  end

  def payments_dashboard(params)
    @start_date = params[:payments].present? ? params[:payments][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:payments].present? ? params[:payments][:end_date] : [Time.now.beginning_of_month.to_date]

    @payments_data = Payment
    .includes(:payu_response, payment_mass_doc: :payment_mass_detail)
    .includes([billing_document: {isa: { funding_opportunity: :fund}}])
    .includes(billing_document: {isa: :user})
    .where('payments.payment_date BETWEEN ? AND ?', @start_date, @end_date)
    .where('payments.value > 0')
    .where.not(payment_source: "payment_agreement")
  end

  def students_general_information_dashboard(params)
    @funding_opportunity_list = FormList.all_funding_opportunities_list(current_company)
    @funding_opportunities = params[:general_information].present? ? params[:general_information][:funding_opportunity] : [@funding_opportunity_list[:options][:values].first]

    @students_general_information = User
    .students
    .joins(:application, :isa)
    .includes({funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]] }, :contact_info, :sociodemographic, {reporting_to: :supervisor},:personal_information,{location: [:city]}, {funded_programs: [:major, :institution, :disbursement, :isa]}, :active_income_information,:student_financial_information)
    .where(applications: { resource_type: "FundingOpportunity", resource_id: @funding_opportunities})
    .distinct()
  end

  def active_students_dashboard(params)
    @funding_opportunity_list = FormList.all_funding_opportunities_list(current_company)
    @funding_opportunities = params[:active_students_dashboard].present? ? params[:active_students_dashboard][:funding_opportunity] : [@funding_opportunity_list[:options][:values].first]

    @active_students = User
    .students
    .joins(:application)
    .includes({funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]] },:contact_info, :sociodemographic,:personal_information,{location: [:city, :state]}, {funded_programs: [:major, :institution, :disbursement]}, :active_income_information,:student_financial_information,{reporting_to: :supervisor})
    .where(applications: { resource_type: "FundingOpportunity", resource_id: @funding_opportunities})
    .distinct()
  end

  def projected_disbursement_dashboard(params)
    @start_date = params[:projected_disbursements].present? ? params[:projected_disbursements][:start_date] : [Time.now.beginning_of_month.to_date]
    @end_date = params[:projected_disbursements].present? ? params[:projected_disbursements][:end_date] : [Time.now.beginning_of_month.to_date]

    @projected_disbursement = Disbursement
      .includes({student_academic_information: [:major, {institution: :bank_account}, {user: [:bank_account, :application , {reporting_to: :supervisor}, {funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]]}]}]})
      .where(student_academic_informations: {users: {applications: { resource_type: "FundingOpportunity"}}})
      .where('forcasted_date BETWEEN ? AND ?', @start_date, @end_date)
  end

  def references_dashboard(params)
    @funding_opportunity_list = FormList.all_funding_opportunities_list(current_company)
    @funding_opportunities = params[:references].present? ? params[:references][:funding_opportunity] : [@funding_opportunity_list[:options][:values].first]

    @references_data = User
    .joins(:application)
    .includes({funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]] }, {reporting_to: :supervisor},:reference, {location: :city} )
    .where(applications: { resource_type: "FundingOpportunity", resource_id: @funding_opportunities})
  end

  def employability_dashboard(params)
    @fund_list = FormList.find(25).get_list( current_user, current_company)
    @fund = params[:employability].present? ?  params[:employability][:fund] : [@fund_list[:funds][:values].first]
    
    @employability_data = User
      .students
      .joins(application: {funding_opportunity_from_resource: :fund})
      .includes({funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]] }, {reporting_to: :supervisor}, {funded_programs: [:major, :institution, :isa]}, :user_questionnaire, :active_income_information)
      .where(applications: {funding_opportunity_from_resources: {funds: {id: @fund}}})
      .distinct
  end

  def grades_dashboard(params)
    @terms_for_grades_list = FormList.find(277).get_list(current_user, current_company)
    @terms_for_grades = params[:grades].present? ? params[:grades][:term] : [@terms_for_grades_list[:options][:values].first]

    @grades_data = User
      .students
      .joins(:application, {student_academic_information: {university_grade: :university_course_grade}})
      .includes({funding_opportunity_applications:[funding_opportunity_from_resource: [:fund]] },{reporting_to: :supervisor},{funded_programs: [:major, :institution, {university_grade: :university_course_grade}]})
      .where(student_academic_informations: {university_grades: {period: @terms_for_grades}})
      .distinct
  end
end