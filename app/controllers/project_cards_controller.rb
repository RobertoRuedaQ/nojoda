class ProjectCardsController < ApplicationController
  include RecordsPerPage
  before_action :set_project_card, only: :edit

  def edit
    @tasks = @card.main_tasks.paginate(page: params[:page], per_page: records_per_page)
  end

  private

  def set_project_card
    @card = ProjectCard.find(params[:id])
  end
end
