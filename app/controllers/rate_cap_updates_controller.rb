class RateCapUpdatesController < ApplicationController
  before_action :set_rate_cap_update, only: [:show, :edit, :update, :destroy]

  def index
    @rate_cap_updates = RateCapUpdate.all
  end

  def show
  end


  def new
    @rate_cap_update = RateCapUpdate.new
  end

  def edit
  end

  def create
    @rate_cap_update = RateCapUpdate.new(rate_cap_update_params)

    respond_to do |format|
      if @rate_cap_update.save
        PerformServiceAsync.perform_async('UpdateRateCapService', rate_cap_value: @rate_cap_update.rate_cap_value , country: @rate_cap_update.country )
        format.html { redirect_to rate_cap_updates_path, notice: I18n.t('rate_cap_update.flash.create.success') }
        format.json { render :show, status: :created, location: @rate_cap_update }
      else
        format.html { render :new }
        format.json { render json: @rate_cap_update.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rate_cap_update.update(rate_cap_update_params)
        format.html { redirect_to rate_cap_updates_path, notice: I18n.t('rate_cap_update.flash.create.success') }
        format.json { render :show, status: :ok, location: @rate_cap_update }
      else
        format.html { render :edit }
        format.json { render json: @rate_cap_update.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rate_cap_update.destroy
    respond_to do |format|
      format.html { redirect_to rate_cap_updates_url, notice: 'Rate cap update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_rate_cap_update
      @rate_cap_update = RateCapUpdate.find(params[:id])
    end

    def rate_cap_update_params
      params.require(:rate_cap_update).permit(:rate_cap_value, :responsible_id, :country)
    end
end
