# frozen_string_literal: true

class FilterInteractor < ApplicationInteractor
  def call
    context.ransack = filter
    context.result = context.ransack.result
  end

  private

  def filter
    context.resource.ransack(context.params[:q])
  end
end