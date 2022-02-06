class AcademicStopsController < ApplicationController
	def index
		@academic_stop = AcademicStop.lumniStart(params,current_company, list: current_user.template('AcademicStop','academic_stops',current_user))
		contactAcademicStop = @academic_stop.lumniSave(params,current_user, list: current_user.template('AcademicStop','academic_stops',current_user))
		lumniClose(@academic_stop,contactAcademicStop)
	end

	def new
		@academic_stop = AcademicStop.new
	end

	def create
		@academic_stop = AcademicStop.new(academic_stop_params)
		user = @academic_stop.student_academic_information.user
		if @academic_stop.save
      flash[:success] = I18n.t('students.flash.create.success')
      redirect_to edit_student_path(user)
    else
      flash[:danger] = I18n.t('students.flash.create.fail')
      render :new
    end
		
	end

	def edit
		@academic_stop = AcademicStop.lumniStart(params,current_company, list: current_user.template('AcademicStop','academic_stops',current_user))
		contactAcademicStop = @academic_stop.lumniSave(params,current_user, list: current_user.template('AcademicStop','academic_stops',current_user))
		lumniClose(@academic_stop,contactAcademicStop)
	end

	def update
		@academic_stop = AcademicStop.find(params[:id])
		@academic_stop.attributes = academic_stop_params
		@student_academic_information = StudentAcademicInformation.cached_find(params[:academic_stop][:student_academic_information_id])
		if @academic_stop.save
			flash[:success] = I18n.t('flash.academic_stop_updated')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to edit_student_path(@student_academic_information.user)
	end

	def destroy
		@academic_stop = AcademicStop.lumniStart(params,current_company, list: current_user.template('AcademicStop','academic_stops',current_user))
		contactAcademicStop = @academic_stop.lumniSave(params,current_user, list: current_user.template('AcademicStop','academic_stops',current_user))
		lumniClose(@cluster,contactAcademicStop)
	end

	def create_application
    application = Application.where(user_id: current_user.id, status: 'under_review', application_case: 'academic_stop').first
    if application.nil?
      @academic_stop = AcademicStop.create(student_academic_information_id: current_user.funded_academic_information.id, status: 'under_review')
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'academic_stop',resource_type: 'AcademicStop', resource_id: @academic_stop.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end

	private

	def academic_stop_params
		params.require(:academic_stop).permit(:student_academic_information_id,:start_date,:end_date,:status,:explanation)
	end
end