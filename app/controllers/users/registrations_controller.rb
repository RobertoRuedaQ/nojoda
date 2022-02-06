# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RestrictedCompanies
  prepend_before_action :check_captcha, only: [:create]
  layout :choose_layout
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super 
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:password,:password_confirmation,:first_name,:last_name,:avatar,:company_id,:team_profile_id,:type_of_account,:time_zone])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email,:password,:password_confirmation,:first_name,:last_name,:avatar,:company_id,:team_profile_id,:type_of_account,:time_zone])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

    def choose_layout
    if action_name == "edit"
      "main/layout-1"
    else
      "main/layout-without-sidenav"
    end
  end

  private
    def check_captcha
      if Rails.env == 'production'
        unless verify_recaptcha
          self.resource = resource_class.new sign_up_params
          resource.validate # Look for any other validation errors besides Recaptcha
          set_minimum_password_length
          respond_with resource
        end 
      end
    end

end
