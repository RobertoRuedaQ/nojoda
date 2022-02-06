class TeamSupervisorBatchesController < ApplicationController
  before_action :set_batch, only: [:edit, :update]

  def index
    @batches_ransack = TeamSupervisorBatch.ransack(params[:q])
    @batches = @batches_ransack.result.paginate(page: params[:page], per_page: 25)
  end

  def new
    @batch = TeamSupervisorBatch.new
  end

  def create
    @batch = TeamSupervisorBatch.new(batch_params)
    interactor = GenerateTeamSupervisorRelationshipsInteractor.call(batch: @batch)

    if interactor.success?
      flash[:success] = I18n.t('team_supervisor_batch.flash.create.success')
      redirect_to edit_team_supervisor_batch_path(interactor.batch)
    else
      flash[:danger] = interactor.message
      render :new
    end
  end

  def edit
    @file_records = @batch.get_records
    students_ids = @file_records.pluck('student_id')
    @applied_records = TeamSupervisor.includes(:team_member, :supervisor, :support_role)
                                     .where(team_member_id: students_ids).distinct
    @supervisors = User.where(email: @file_records.pluck('support_email')).distinct
    @students = User.where(id: students_ids).distinct
  end

  def update
    @batch.assign_attributes(batch_params)
    if @batch.valid_file?
      if @batch.save
        flash[:success] = I18n.t('team_supervisor_batch.flash.update.success')
      else
        flash[:danger] = I18n.t('team_supervisor_batch.flash.update.danger')
      end
    else
      flash[:danger] = I18n.t('team_supervisor_batch.flash.create.invalid_file')
    end

    redirect_to edit_team_supervisor_batch_path(@batch)
  end

  private

  def batch_params
    params.require(:team_supervisor_batch).permit(:description, :relationships_file)
  end

  def set_batch
    @batch = TeamSupervisorBatch.find(params[:id])
  end
end