class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'errors'

  # 404 error
  def not_found; end

  # 500 error
  def internal_error; end
end