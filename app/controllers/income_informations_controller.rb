class IncomeInformationsController < ApplicationController
  before_action :set_income_dependencies, only: %i(edit create_new_income update)
  before_action :manage_income_information, only: %i(new create edit update destroy)
  
  include LumniGeneral

  def index
    list = template
    @ransack = IncomeInformation.lumniStart(
      params, current_company, list: list
    ).includes([:income_certificate_attachments, :user]).ransack(params[:q])

    @income_information = @ransack.result.paginate(page: params[:page], per_page: 25)

    contactIncomeInformation = @income_information.lumniSave(
      params ,current_user, list: list
    )
    lumniClose(@income_information, contactIncomeInformation)
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  def create_new_income
    config = {}
    config[:list] = template
    config[:model] = 'incomeinformation'
    @income_information = IncomeInformation.create(setting_params(params,nil,config))
  end


  def create_application
    application = Application.joins(:income_information).where(income_informations: {user_id: current_user.id, status: 'under_review'}).first
    if application.nil?
      @income_information = IncomeInformation.create(user_id: current_user.id, status: 'under_review')
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'income_information',resource_type: 'IncomeInformation', resource_id: @income_information.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end

  def edit_record
    application = Application.joins(:income_information).find_by(income_informations: {user_id: current_user.id, status: 'under_review', parent_id: params[:id]})
    if application.nil?
      @income_information = IncomeInformation.cached_find(params[:id]).dup
      @income_information.status = 'under_review'
      @income_information.parent_id = params[:id]
      @income_information.save
      new_application = Application.new({status: 'active',user_id: current_user.id,application_case: 'income_information',resource_type: 'IncomeInformation', resource_id: @income_information.id})
      if new_application.save
        redirect_to edit_application_path(new_application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end




    # @income_information = IncomeInformation.cached_find(params[:id])
    # application = @income_information.application
    # if application.nil?
    #   application = Application.create({status: 'active',user_id: @income_information.user_id,application_case: 'income_information',resource_type: 'IncomeInformation', resource_id: @income_information.id})
    # end
    # redirect_to edit_application_path(application)
  end

  private

  def manage_income_information
    list = template
    @income_information = IncomeInformation.lumniStart(
      params, current_company, list: list
    )

    contactIncomeInformation = @income_information.lumniSave(
      params ,current_user, list: list
    )
    lumniClose(@income_information, contactIncomeInformation)
  end

  def template
    if @section
      @section.cached_form_template.template_hash(
        current_user, current_company
      )
    else
      current_user.template(
        'IncomeInformation','income_informations', current_user
      )
    end
  end

  def set_income_dependencies
    return unless params[:temp]

    @hidden_fields = params.require(:temp).permit(
      :application_id, :section, :target_module
    ).to_h || {}    
    @application = Application.find(@hidden_fields['application_id'])
    @section = OriginationSection.find(@hidden_fields['section'])
  end
end
