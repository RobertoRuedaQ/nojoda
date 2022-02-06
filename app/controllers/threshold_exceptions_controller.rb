class ThresholdExceptionsController < ApplicationController
  before_action :set_threshold_exception, only: [:edit, :update, :destroy]
  before_action :set_isa, only: [:create, :destroy, :update, :edit]
  
  def edit; end

  def update
    if @threshold_exception.update(threshold_params)
      @isa.save
      flash[:success] = 'Se actualizó el valor exitosamente'
    else
      flash[:danger] = 'Hubo un error'
    end

    render :edit
  end

  def new; end

  def create
    @threshold_exception = FundingOptionConfig.new({funding_option_id: @isa.funding_option.id, name: 'threshold_exception'})
    @threshold_exception.value = threshold_params[:value]
    if @threshold_exception.save
      @isa.save
      flash[:success] = 'Se creó la excepción del salario minimo para pago exitosamente.'
    else
      flash[:danger] = 'Hubo un error'
    end

    redirect_to edit_isa_threshold_exception_path(@threshold_exception.funding_option.isa, @threshold_exception)
  end

  def destroy
    if @threshold_exception.destroy
      @isa.save
      flash[:success] = 'La excepción de salario minimo para pago fue eliminada.'
    else
      flash[:danger] = 'Hubo un error al intentar eliminar'
    end

    redirect_to edit_student_path(@threshold_exception.funding_option.isa.user)
  end

  private

  def threshold_params
    params.require(:threshold_exception).permit(:value)
  end

  def set_isa
    @isa = Isa.find(params[:isa_id])
  end

  def set_threshold_exception
    @threshold_exception = FundingOptionConfig.find(params[:id]) 
  end
end