Rails.application.routes.draw do
  resources :wompi_responses do
    collection do
      get '/sync_payment_confirmation/:transaction_external_id' => 'wompi_responses#sync_payment_confirmation'
      post '/async_payment_confirmation' => 'wompi_responses#async_payment_confirmation'
    end
  end
  resources :wompi_transactions do
    collection do
      post :wompi_transaction
      get :cash_payment_info
    end
  end
  resources :wompi_gateways
  resources :mercado_pago_transactions do
    collection do 
      post :mercado_pago_transaction
    end
  end
  resources :mercado_pago_responses do
    collection do
      get '/sync_payment_confirmation/:transaction_external_id' => 'mercado_pago_responses#sync_payment_confirmation'
      post '/async_payment_confirmation/:transaction_external_id' => 'mercado_pago_responses#async_payment_confirmation'
    end
  end
  resources :mercado_pago_gateways
  resources :rate_cap_updates
  resources :valuation_details
  resources :valuation_histories
  resources :curreny_histories
  resources :conciliation_informations
  get '404', to: 'errors#not_found'
  get '500', to: 'errors#internal_error'
  resources :default_matrices
  resources :cancellation_requests
  resources :isa_amendment_disbursements
  resources :isa_amendments
  resources :funding_option_disbursements
  resources :cancellation_configs
  resources :modeling_main_sencibilities
  resources :modeling_sencibility_details
  resources :modeling_sencibilities
  resources :modeling_flow_summaries
  resources :modeling_flow_details
  resources :modeling_flow_extras
  resources :modeling_flow_fees
  resources :modeling_flows
  resources :personal_covid_emergencies
  resources :batch_details
  resources :general_requests
  resources :academic_requests do 
    member do
      post 'start_origination'
    end
  end
  resources :process_originations
  resources :academi_originations
  resources :dashboards
  resources :legacy_statuses
  resources :payment_mass_docs
  resources :disbursement_cancellations
  resources :ipcs
  resources :student_reviews
  resources :modeling_variables
  resources :complementary_originations
  resources :searchers
  resources :activities_details
  resources :complementary_activities
  resources :payment_mass_details do 
    member do
      post 'search_matches'
      post 'create_payments'
      post 'unapply_payment'
    end
  end
  resources :payment_masses
  resources :collections
  resources :covid_configs
  resources :covid_emergencies do 
    collection do 
      post 'set_covid_option'
    end
  end
  resources :social_works
  resources :user_aggregations
  resources :migration_trackings
  resources :migration_jobs
  resources :questionnaire_exceptions
  resources :requesting_modifications
  resources :modeling_fees
  resources :payment_excesses
  resources :custom_disbursements
  resources :support_roles
  resources :income_variable_incomes do 
    member do
      post 'update_variable_income'
    end
  end
  resources :generate_matches
  resources :generate_from_files
  resources :payment_originations
  resources :funding_opportunity_invitations
  resources :payu_confirmations do
    member do 
      post :payu_confirmation
    end
  end
  resources :payu_additional_infos
  resources :payu_transactions do
    collection do 
      post :payu_transaction
    end
  end
  resources :payu_extra_params
  resources :payu_responses do 
    member do
      get 'transaction_external'
    end
  end
  resources :payment_configs
  resources :payu_gateways
  resources :academic_stops do 
    collection do 
      post 'create_application'
    end
  end
  resources :payment_batches
  resources :payment_matches
  resources :payments do
    member do
      post 'manual_payment_application'
      post 'send_manual_payment_application'
    end
  end
  resources :billing_document_matches
  resources :billing_document_details
  resources :payment_agreements do 
    collection do 
      post 'simulate'
    end
  end
  resources :university_course_grades do 
    collection do
      post 'set_grades'
    end
  end
  resources :application_committees
  resources :disbursement_payments
  resources :disbursement_matches
  resources :disbursement_originations
  resources :disbursement_requests do
    member do
      post 'request_disbursement'
      post 'send_disbursement_request'
    end
  end
  resources :investment_decisions
  resources :invest_committees do
    member do
      post 'approve'
      post 'reject'
      get 'application_committee'
      get 'invest_decision'
    end
  end
  resources :info_terpels
  resources :list_inputs
  resources :form_inputs
  resources :api_histories
  resources :research_inputs
  resources :research_processes
  resources :funding_tokens do
    collection do
      post 'verify_token'
    end
  end
  resources :model_and_fields
  resources :not_alloweds, only: [:index]
  resources :feedbacks
  resources :funding_needs
  resources :funding_disbursements
  resources :billing_documents do
    member do 
      post 'generate_document'
      post 'refresh_billing_document'
      post 'activate_billing_document'
      post 'set_webcheckout'
      post :update_status
    end 
    collection do 
      post 'set_payment'
    end
  end
  resources :migration_picklists
  resources :backup_infos
  resources :backup_picklists
  resources :backup_fields
  resources :backup_objects do
    collection do 
      get 'create_backup'
      get 'create_sf_structure'
    end
  end
  resources :university_grades do
    member do 
      post 'storing_university_grades'
    end
    collection do 
      post 'approve_section'
    end
  end

  resources :children do
    collection do
      post 'create_application_child'
      post 'new_record'
    end
    member do
      get 'edit_application_child'
      post 'update_application_child'
    end
  end
  resources :healths
  resources :bff_questions
  resources :school_grades
  resources :references do
    collection do
      post 'create_application_reference'
      post 'new_record'
    end
    member do
      get 'edit_application_reference'
      post 'update_application_reference'
    end
  end
  resources :income_informations do
    collection do 
      post 'create_new_income'
      post 'create_application'
    end
    member do
      get 'edit_record'
    end
  end
  resources :bank_accounts do 
    collection do
      post 'create_application'
    end
  end
  resources :sociodemographics
  resources :check_modes
  resources :check_fields
  resources :check_objects do 
    collection do 
      post 'update_objects'
    end
  end
  resources :condonations
  resources :disbursements do 
    member do
      post 'activate'
      post 'force_disbursement_payment'
      get 'activate_disbursement_cancellation_application'
    end
  end
  resources :isa_statuses
  resources :isas do
    resources :isa_amendments
    resources :conciliation_informations
    resources :threshold_exceptions
    member do 
      post 'set_isa_status'
      post 'disable_status'
      get 'activate_disbursement_cancellation_application'
      post 'activate_conciliation_application'
    end
  end
  resources :funding_option_statuses
  resources :funding_option_configs
  resources :funding_options do
    resources :modeling_flows
    member do 
      get 'getting_funding_option'
      get 'export_modeling_to_r'
      post 'update_cap_value'
    end
    collection do 
      get 'modeling_students'
    end
    member do 
      post 'changes_visibility'
    end
  end
  resources :applicants do 
    member do
      post 'refresh_modeling'
      post 'withdrawn_application'
    end
    collection do 
      post 'search_applicants'
    end
    member do 
      get 'project'
      get 'communications'
    end
  end
  resources :school_infos
  resources :university_infos
  resources :student_academic_informations do 
    member do
      get 'edit_record'
      post 'request_diploma_delivery'
    end
  end
  resources :multiple_choices
  resources :student_debts do
    collection do 
      post 'create_application_debt'
    end
  end
  resources :student_expenses
  resources :student_financial_informations do
    collection do
      post 'create_application'
    end
  end
  resources :student_configs
  resources :contracts
  resources :notifications do 
    member do
      post 'got_it'
    end
  end
  resources :notification_cases
  resources :bizdev_operations
  resources :migrations_backups do
    member do
      post 'show_backup'
    end
  end
  resources :migration_fields
  resources :bizdev_businesses do
    collection do
      post 'create_team'
      post 'destroy_team'
      get 'new_opportunity'
    end
  end
  resources :migration_accumulations
  resources :questionnaire_accumulations
  resources :research_model_infos
  resources :research_filters
  resources :research_variables
  resources :geography_codes
  resources :geographies
  resources :modeling_matches
  resources :modeling_fixed_conditions
  resources :modelings do
    member do
      post 'select_proposal'
    end
  end
  resources :credit_history_checks
  resources :application_section_tracks
  resources :user_questionnaire_scores
  resources :user_questionnaire_answers do 
    member do 
      post 'save_answers'
    end
  end
  resources :user_questionnaires do 
    member do
      post  'new_questionnaire_match'
      get   'test_taker'
      get 'start_test'
      post 'cancel_test'
      get 'finish_test'
      get 'display_result'
      get 'confirm_result'
      post 'save_confirmation'
      post 'request_correction'
      get 'get_start'
    end
  end

  resources :project_task_translates
  resources :communication_users do
    member do
      post 'load_message'
    end
  end
  resources :project_favorites
  resources :docs_notes
  resources :docs_faqs
  resources :docs_fields
  resources :docs_generals do
    collection do 
      get 'documentation'
    end
  end

  resources :student_routes do 
    collection do
      post 'profile'
    end
  end
  resources :funding_opportunity_teams do
    collection do
      post 'create_supervisor'
      post 'destroy_supervisor'
    end
  end
    
  resources :origination_sections
  resources :origination_modules
  resources :originations do
    collection do
      post 'sort'
    end
    member do 
      get 'clone_origination'
      post 'create_clone_origination'
    end      
  end
  resources :team_profile_templates
  resources :team_approvals
  resources :form_labels do
    collection do 
      post 'create_label'
    end
    member do 
      post 'update_label'
    end
  end
  resources :form_list_dbs
  resources :form_list_values do 
    member do
      post 'modify_form_list_value'
    end
  end
  resources :form_lists do
    collection do
      post 'form_functionality'
      post 'form_values'
      post 'translate_functionality'
    end
    member do 
      post 'clone'
      get 'new_clone'
    end
  end
  resources :form_attributes do 
    collection do 
      post 'update_value_field'
    end
  end
  resources :form_fields do
    collection do 
      get 'edit_file_field'
    end
  end
  resources :form_templates do
    member do 
      post 'uniform_grid'
      get 'clone_template'
      patch 'create_clone'
    end
    collection do
      post 'sort'
    end
    member do
      post 'field_form'
    end
  end
  resources :team_profiles do 
    member do 
      post 'template_table'
      post 'role_table'
    end
  end
  resources :team_supervisors do
    collection do
      post 'create_supervisor'
      post 'destroy_supervisor'
    end
  end

  resources :team_supervisor_batches
  resources :student_email_batches, except: :show
  resources :student_token_batches, except: :show
  resources :indicator_repetitions
  resources :indicator_cases
  resources :indicator_inputs
  resources :indicator_references
  resources :indicator_histories
  resources :indicator_types
  resources :communication_cases
  resources :communication_footers
  resources :communication_headers
  resources :communication_templates do
    member do
      get 'preview', defaults: { format: 'pdf' }
    end
  end
  resources :project_comments do
    member do 
      get 'show_chat'
    end
  end

  
  authenticate :user do
    require 'sidekiq/web'
    require 'sidekiq-scheduler/web'
    mount Sidekiq::Web => '/workermonitor'
  end

  resources :object_orders
  resources :project_tasks do
    collection do 
      post 'new_task'
    end
    member do
      post 'show_project_tab'
      post 'update_card'
      get 'edit_task'
      get 'new_checklist'
      get 'show_checklist'
      post 'done'
      post 'undone'
      post 'check_read_task'
      post 'uncheck_read_task'
    end
  end
  resources :project_task_type_users
  resources :project_task_types
  resources :project_cards
  resources :project_teams do
    member do 
      get 'new_team_member'
      post 'update_teams'
    end
  end
  resources :projects do
    member do
      post 'select_favorite'
      post 'deselect_favorite'
    end
    collection do
      post 'sort'
    end
  end
  resources :student_answers
  resources :student_scores
  resources :answers do 
    collection do
      post 'sort'
    end
    member do
      post 'new_answer'
      post 'edit_answer'
    end
  end

  resources :questions do
    collection do
      post 'sort'
    end
    member do
      post 'new_question'
      post 'edit_question'
    end
  end
  resources :questionnaires do
    collection do
      post 'sort'
      get 'migrate'
    end
    member do 
      post 'new_section'
      post 'edit_section'
      get 'body_section'
      get 'clone'
      patch 'create_clone'
    end
  end
  resources :pricing_vectors
  resources :eligibility_usas
  resources :locations do
    collection do
      post 'regions'
      post 'cities'
      post 'create_application'
    end
  end
  resources :pricing_tables
  resources :pricing_details
  resources :clusters
  
  resources :majors do
    resources :clusters
  end

  resources :institutions do
    resources :majors
    resources :clusters
    collection do
      post 'set_major'
    end 
  end

  resources :black_rock_datas do 
    collection do 
      post 'create_application'
    end
  end

  resources :approval_archive
  resources :approval_matches
  resources :approval_managers do
    member do 
      post 'approve'
      post 'reject'
      post 'cancel'
      patch 'reasign'
    end
  end

  resources :fund_withdrawals do 
    collection do 
      post 'create_application'
    end
  end


  resources :migrations do 
    collection do
      post 'migrate'
      post 'general_migrations'
      post 'reset_job'
    end
    member do
      get 'process_migration_tracking'
    end
  end
  resources :application_components
  resources :students do 
    collection do 
      post 'simulate_student'
      post 'filter_students'
      post 'set_funding_opportunity_filter'
      post 'create_application'
    end
    member do 
      get 'full'
      get 'management'
      get 'project'
      get 'communications'
      get 'workshops'
      get 'support_team'
      get 'academic_info'
      get 'social_service'
      get 'contract_amendment'
      get 'conciliation'
      get 'payment'
      get 'application'
      get 'legal_documents'
      get 'financial_information'
    end

  end
  resources :legal_matches do
    member do
      get 'legal_document', defaults: { format: 'pdf' }
      get 'preview', defaults: { format: 'pdf' }
      get 'download_pdf'
    end
  end
  resources :companies
  resources :countries do
    resources :default_matrices
  end
  resources :legal_documents do 
    member do
      post 'send_preview'
      post 'eligibility_criteria'
      get 'preview', defaults: { format: 'pdf' }
    end
    collection do 
      post 'export_bff_disclosures'
    end
  end
  resources :home
  resources :funding_opportunities do
    member do
      get 'clone_funding_opportunity'
      patch 'create_clone_funding_opportunity'
    end
  end
  resources :funds do
      member do 
        post 'valuation'
      end
      resources :cancellation_configs
  end
  resources :applications do
    member do
      post 'reactivate_application'
      get 'reactivate_regular_application'
      post 'storing_application_info'
      get 'submit_application'
      post 'edit_record'
      post 'update_record'
      post 'set_show_financial_proposals'
      post 'approve_changes'
      post 'reject_changes'
      post 'approve_isa_amendment'
      post 'reject_isa_amendment'
      get 'change_disbursement_request'
    end
    collection do 
      post 'creating_record'
      post 'load_target_modules'
      post 'set_disbursements'
    end
  end
  resources :personal_informations do
    collection do
      post 'create_application'
    end
  end
  resources :history
  resources :trashes do
    member do
      post 'remove_attachment'
    end 
  end
  resources :contact_infos do
    collection do
      post 'create_application'
    end
  end
  resources :roles do
    collection do
      post 'create_role'
      post 'destroy_role'
      post 'asign_approver'
    end
  end
  resources :profiles
  resources :teams do 
    member do 
      post 'simulate'
    end
  end
  resources :mains do
    collection do
      get 'clear_cache'
      post 'set_projects_summary'
      get 'disbursement'
      get 'billing_document'
      get 'academic_information'
      get 'income_information'
      get 'complementary_activity'
      get 'social_work'
      get 'conciliation'
      get 'payment'
      get 'contact'
      get 'student_financial_information'
      get 'student_legal_documents'
      get 'novelty'
    end
  end

  resources :application_follow_ups

  get 'platzi_information', to: 'platzi_information#index'


  devise_for :users, :controllers => { 
    sessions: "users/sessions", 
    registrations: "users/registrations",
    omniauth: "users/amniauth",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    unlocks: "users/unlocks"
  }

  namespace :api do
    namespace :v1 do
      resources :students do
        collection do
          get :find
        end
      end
      resource :signio_records do
        collection do
          post :update_legal_match_file
          post :delete_legal_match
        end
      end
    end
  end

  root 'home#index'
end
