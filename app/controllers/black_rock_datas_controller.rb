class BlackRockDatasController < ApplicationController
  def index
  end

  def show
    @black_rock_data = BlackRockData.find_by(user_id: current_user.id)
  end

  def edit
    @black_rock_data = BlackRockData.find_by(user_id: current_user.id)
  end

  def update
    @black_rock_data = BlackRockData.find_by(user_id: current_user.id)
  end

  def destroy
    @black_rock_data = BlackRockData.find_by(user_id: current_user.id)
  end
  
  def create_application

    application = Application.where(user_id: current_user.id, status: 'under_review', application_case: 'black_rock_data').first
    if application.nil?
      @black_rock_data = BlackRockData.create(user_id: current_user.id)
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'black_rock_data',resource_type: 'BlackRockData', resource_id: @black_rock_data.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end

end
