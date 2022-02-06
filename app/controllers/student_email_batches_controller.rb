class StudentEmailBatchesController < ApplicationController
  before_action :set_student_email_batch, only: [:edit, :update]

  def index
    @student_email_batches = StudentEmailBatch.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @student_email_batch = StudentEmailBatch.new
  end

  def create
    @student_email_batch = StudentEmailBatch.new(student_email_batch_params)
    interactor = EmailSenderInteractor.call(batch: @student_email_batch)

    if interactor.success?
      @student_email_batch.save
      flash[:success] = I18n.t('team_supervisor_batch.flash.create.success')
      redirect_to edit_student_email_batch_path(@student_email_batch)
    else
      flash[:danger] = interactor.message
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def student_email_batch_params
    params.require(:student_email_batch).permit(:email_case, :email_list)
  end

  def set_student_email_batch
    @student_email_batch = StudentEmailBatch.find(params[:id])
  end
end
