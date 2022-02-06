class StudentTokenBatchesController < ApplicationController

  before_action :set_student_token_batch, only: [:edit, :update]
  
  def index
    @student_token_batches = StudentTokenBatch.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @student_token_batch = StudentTokenBatch.new
  end

  def create
    @student_token_batch = StudentTokenBatch.new(student_token_batch_params)
    interactor = GenerateTokensInteractor.call(batch: @student_token_batch)

    if interactor.success?
      @student_token_batch.save
      flash[:success] = I18n.t('student_token_batch.flash.create.success')
      redirect_to edit_student_token_batch_path(@student_token_batch)
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

  def student_token_batch_params
    params.require(:student_token_batch).permit( :tokens_list, :status, :funding_opportunity_id, :description)
  end

  def set_student_token_batch
    @student_token_batch = StudentTokenBatch.find(params[:id])
  end
end
