class IsaStatusesController < ApplicationController
	def index
		@isa_status = IsaStatus.lumniStart(params,current_company, list: current_user.template('IsaStatus','isa_statuses',current_user))
		contactIsaStatus = @isa_status.lumniSave(params,current_user, list: current_user.template('IsaStatus','isa_statuses',current_user))
		lumniClose(@isa_status,contactIsaStatus)
	end

	def new
		@isa_status = IsaStatus.new
	end

	def create
		@isa_status = IsaStatus.new(isa_status_params)
		user = @isa_status.isa.user
		if @isa_status.save
      flash[:success] = I18n.t('students.flash.create.success_status')
      redirect_to edit_student_path(user)
    else
      flash[:danger] = I18n.t('students.flash.create.fail_status')
      render :new
    end
	end


	def edit
		@isa_status = IsaStatus.lumniStart(params,current_company, list: current_user.template('IsaStatus','isa_statuses',current_user))
		contactIsaStatus = @isa_status.update(isa_status_params)
		contactIsaStatus = @isa_status.lumniSave(params,current_user, list: current_user.template('IsaStatus','isa_statuses',current_user))
		lumniClose(@isa_status,contactIsaStatus)
	end

	def update
		@isa_status = IsaStatus.find(params[:id])
		user = @isa_status.isa.user
		@isa_status.update(isa_status_params)
		if @isa_status.save
      flash[:success] = I18n.t('students.flash.update.success_status')
      redirect_to edit_student_path(user)
    else
      flash[:danger] = I18n.t('students.flash.update.fail_status')
      render :new
    end
	end

	def destroy
		@isa_status = IsaStatus.lumniStart(params,current_company, list: current_user.template('IsaStatus','isa_statuses',current_user))
		contactIsaStatus = @isa_status.lumniSave(params,current_user, list: current_user.template('IsaStatus','isa_statuses',current_user))
		lumniClose(@cluster,contactIsaStatus)
	end

	private

	def isa_status_params
		params.require(:isa_status).permit(:status, :start_date, :end_date, :isa_id, :status_case, :phase)
	end
end