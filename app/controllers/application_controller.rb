class ApplicationController < ActionController::Base
  include ApplicationHelper
  include FormInfoHelper
  include ListsHelper
  include LumniDataStructureInformation
  include LumniApi
  include ApplicationHelper
  include PlatziHelper
  # Machine Learning
  # require 'numo/linalg/autoloader'
  # require 'parallel'
  require 'rumale'




  protect_from_forgery unless: :export_modeling_to_r?

  before_action :check_banned_countries
  before_action :set_time_zone, unless: :devise_controller?
  before_action :set_locale, unless: :devise_controller?
  before_action :set_devise_locale, if: :devise_controller?
  before_action :authenticate_user!, unless: [:home_controller?,:not_allowed_controller?,:transaction_controller?,:export_modeling_to_r?]
  before_action :load_time_zone
  before_action :check_questionnaires, except: [:set_locale], unless: :devise_controller?
  before_action :clean_simulated_session
  before_action :redirecting_to_own_company, unless: :devise_controller?
  before_action :validate_platzi_users, unless: :platzi_information_controller?
  before_action :set_current_user
  include Pundit

  add_flash_types :danger, :info, :warning, :success
  # Default layout
  layout 'main/layout-1'

  def export_modeling_to_r?
    controller_name == 'funding_options' && action_name == 'export_modeling_to_r'
  end

  def clean_simulated_session
    if !user_signed_in?
      session[:original_account] = nil
    end
  end

  def redirecting_to_own_company
    if user_signed_in? && !current_user.staff?
      if current_subdomain != current_user.cached_company_url && !current_subdomain.include?('localhost') && !current_subdomain.include?('lumni.org') 
        redirect_to "https://" + current_user.cached_company_url
      end
    end
  end

  def validate_platzi_users
    return unless user_signed_in?

    if platzi_user?(current_user) && platzi_time_expired?
      redirect_to platzi_information_path
    end 
  end

  def check_banned_countries
    begin
      if Rails.env == 'production'
        banned_countries = ['CN','JP']
        target_country = Geocoder.search(request.remote_ip).first.country
        begin
          if !target_country.nil? && banned_countries.include?(target_country)
            redirect_to root_path
          end
        rescue Exception => e
          
        end
      end
    rescue Exception => e
      puts 'IP verifier is not working'
    end

  end

  def after_sign_out_path_for(resource_or_scope)
    clear_cookies
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    # set_current_company_to_cookies
    super
  end

  def clear_cookies
    cookies.delete(:current_company_id)
  end

  def check_questionnaires
    if user_signed_in? && current_user.questionnaire_status == 'ongoing' && params[:controller] != 'user_questionnaires' && params[:controller] != 'user_questionnaire_answers'
      redirect_to test_taker_user_questionnaire_path(current_user.cached_ongoing_questionnaire.first)
    end
  end


  def clean_lists list
    tempList = []
    list.keys.each_with_index do |l,index|
      unless list[l].keys.include?(:disabled) || system_variables.include?(l.to_s)
        tempList[index] = l
      end      
    end
    return tempList.compact
  end


  def lumniClose reference,saveResult,config = {}
    case saveResult
    when 'unauthorized'
      flashType = 'danger'
      redirect_text = '/mains'
    when 'created','updated','approval_request'
      flashType = 'success'
      redirect_text = '/' + params[:controller] + '/' + reference.id.to_s + '/edit'
    when 'discarded'
      flashType = 'danger'
      redirect_text = '/' + params[:controller]
    else
      flashType = 'warning'
      redirect_text = '/' + params[:controller]
    end
    if saveResult != 'authorized'
      respond_to do |format|
        format.html {
          begin
            flash[flashType.to_sym] = I18n.t('flash.record_' + saveResult)
            redirect_to redirect_text
          rescue
            redirect_to root_path
          end
        }
        format.js {
          begin
            
          rescue
            redirect_to root_path
          end
        }
        format.json {
          begin
          rescue
            redirect_to root_path
          end
        }
      end
    end
  end


  protected

    def set_locale
        if user_signed_in?
          I18n.locale = current_user.language
          session[:language] = current_user.language
        elsif !['es','en'].index(browser_locale(request).to_s).nil? && cookies[:language].nil?
          cookies[:language] = browser_locale(request).to_s
        elsif cookies[:language].nil?
          cookies[:language] = 'en'
        end

        set_devise_locale
    end

    def set_current_company_to_cookies
      if user_signed_in?
        cookies[:current_company_id] = current_company.id
      end
    end

    def set_devise_locale
      if !session[:language].nil?
        I18n.locale = session[:language]
      elsif !cookies[:language].nil?
        I18n.locale = cookies[:language]
      end
    end

    def transaction_controller?
      validation =  ['payu_confirmation', 'async_payment_confirmation'].include?(action_name)
      return validation
    end

    def home_controller?
      controller_name == 'home'
    end

    def not_allowed_controller?
      controller_name == 'not_alloweds'
    end 

    def load_time_zone
      begin
        Time.zone = cookies[:timezone]
      rescue 
        Time.zone = 'Bogota'
      end
    end

    def set_time_zone
      if user_signed_in?
        cookies[:timezone] = current_user.time_zone
      else
        cookies[:timezone] = 'Bogota'
      end
    end


    def browser_locale(request)
      locales = request.env['HTTP_ACCEPT_LANGUAGE'] || ""
      locales.scan(/[a-z]{2}/).find do |locale|
        I18n.available_locales.include?(locale.to_sym)
      end
    end

    private

    def set_current_user
      User.current = current_user
    end

end