class MajorsController < ApplicationController
  def index
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user)).limit(1000)
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  def new
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user))
    set_institution
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  def create
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user))
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  def edit
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user))
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  def update
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user))
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  def destroy
    @major = Major.lumniStart(params,current_company, list: current_user.template('Major','majors',current_user))
    majorResult = @major.lumniSave(params,current_user, list: current_user.template('Major','majors',current_user))
    lumniClose(@major,majorResult)
  end

  private

  def set_institution
    return unless params[:institution_id]

    @major.institution_id = params[:institution_id]
  end
end
