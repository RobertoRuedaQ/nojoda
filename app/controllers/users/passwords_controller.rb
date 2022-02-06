# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  include RestrictedCompanies
  prepend_before_action :check_captcha, only: [:create]
  layout 'main/layout-without-sidenav'
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end

  private

  def check_captcha
    if Rails.env == 'production'
      unless verify_recaptcha
        self.resource = resource_class.new
        resource.validate # Look for any other validation errors besides Recaptcha
        respond_with_navigational(resource) { render :new }
      end
    end

  end
end
