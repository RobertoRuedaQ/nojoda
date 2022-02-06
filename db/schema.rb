# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2021_11_10_144733) do
=======
ActiveRecord::Schema.define(version: 2021_11_09_225549) do
>>>>>>> fae7d27a (update information to match webhook)

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "academi_originations", force: :cascade do |t|
    t.bigint "courses_id"
    t.bigint "partial_scores_id"
    t.bigint "final_scores_id"
    t.bigint "diploma_delivery_id"
    t.bigint "funding_opportunity_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["courses_id"], name: "index_academi_originations_on_courses_id"
    t.index ["diploma_delivery_id"], name: "index_academi_originations_on_diploma_delivery_id"
    t.index ["discarded_at"], name: "index_academi_originations_on_discarded_at"
    t.index ["external_id"], name: "index_academi_originations_on_external_id"
    t.index ["final_scores_id"], name: "index_academi_originations_on_final_scores_id"
    t.index ["funding_opportunity_id"], name: "index_academi_originations_on_funding_opportunity_id"
    t.index ["partial_scores_id"], name: "index_academi_originations_on_partial_scores_id"
  end

  create_table "academic_requests", force: :cascade do |t|
    t.bigint "student_academic_information_id"
    t.string "request_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_academic_requests_on_discarded_at"
    t.index ["external_id"], name: "index_academic_requests_on_external_id"
    t.index ["student_academic_information_id"], name: "index_academic_requests_on_student_academic_information_id"
  end

  create_table "academic_stops", force: :cascade do |t|
    t.bigint "student_academic_information_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "explanation"
    t.index ["discarded_at"], name: "index_academic_stops_on_discarded_at"
    t.index ["external_id"], name: "index_academic_stops_on_external_id"
    t.index ["student_academic_information_id"], name: "index_academic_stops_on_student_academic_information_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities_details", force: :cascade do |t|
    t.string "detail_case"
    t.string "activity_case"
    t.string "name"
    t.string "category"
    t.bigint "user_id"
    t.string "status"
    t.date "completiton_date"
    t.string "term"
    t.float "score"
    t.string "url"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mentor_first_name"
    t.string "mentor_last_name"
    t.string "mentor_identification_number"
    t.string "mentor_email"
    t.index ["discarded_at"], name: "index_activities_details_on_discarded_at"
    t.index ["external_id"], name: "index_activities_details_on_external_id"
    t.index ["user_id"], name: "index_activities_details_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.integer "position"
    t.float "score", default: 0.0
    t.bigint "question_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_answers_on_discarded_at"
    t.index ["external_id"], name: "index_answers_on_external_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "api_histories", force: :cascade do |t|
    t.string "url"
    t.string "context"
    t.text "response"
    t.string "status"
    t.float "response_time"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verb"
    t.text "params"
    t.index ["discarded_at"], name: "index_api_histories_on_discarded_at"
    t.index ["external_id"], name: "index_api_histories_on_external_id"
    t.index ["user_id"], name: "index_api_histories_on_user_id"
  end

  create_table "application_committees", force: :cascade do |t|
    t.bigint "invest_committee_id"
    t.bigint "application_id"
    t.string "status"
    t.text "notes"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_committees_on_application_id"
    t.index ["discarded_at"], name: "index_application_committees_on_discarded_at"
    t.index ["external_id"], name: "index_application_committees_on_external_id"
    t.index ["invest_committee_id"], name: "index_application_committees_on_invest_committee_id"
  end

  create_table "application_components", force: :cascade do |t|
    t.bigint "funding_opportunity_id"
    t.string "reference_type"
    t.bigint "reference_id"
    t.string "process"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_application_components_on_discarded_at"
    t.index ["external_id"], name: "index_application_components_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_application_components_on_funding_opportunity_id"
    t.index ["process"], name: "index_application_components_on_process"
    t.index ["reference_type", "reference_id"], name: "index_application_components_on_reference_type_and_reference_id"
  end

  create_table "application_follow_ups", force: :cascade do |t|
    t.string "stage"
    t.integer "order", default: 0
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_follow_ups_on_application_id"
  end

  create_table "application_module_tracks", force: :cascade do |t|
    t.bigint "application_id"
    t.bigint "origination_module_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_module_tracks_on_application_id"
    t.index ["discarded_at"], name: "index_application_module_tracks_on_discarded_at"
    t.index ["origination_module_id"], name: "index_application_module_tracks_on_origination_module_id"
  end

  create_table "application_section_tracks", force: :cascade do |t|
    t.bigint "application_id"
    t.bigint "origination_section_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_section_tracks_on_application_id"
    t.index ["discarded_at"], name: "index_application_section_tracks_on_discarded_at"
    t.index ["external_id"], name: "index_application_section_tracks_on_external_id"
    t.index ["origination_section_id"], name: "index_application_section_tracks_on_origination_section_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string "result"
    t.string "status"
    t.string "decision"
    t.string "score"
    t.boolean "show_financial_proposals"
    t.bigint "user_id"
    t.bigint "funding_opportunity_id"
    t.integer "step"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "manual_activation", default: false
    t.date "funding_options_display_date"
    t.string "application_case"
    t.string "resource_type"
    t.bigint "resource_id"
    t.bigint "original_application_id"
    t.integer "typology", default: 0
    t.index ["discarded_at"], name: "index_applications_on_discarded_at"
    t.index ["external_id"], name: "index_applications_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_applications_on_funding_opportunity_id"
    t.index ["original_application_id"], name: "index_applications_on_original_application_id"
    t.index ["resource_type", "resource_id"], name: "index_applications_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "approval_comments", id: :serial, force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "user_id", null: false
    t.text "content", null: false
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_approval_comments_on_discarded_at"
    t.index ["external_id"], name: "index_approval_comments_on_external_id"
    t.index ["request_id"], name: "index_approval_comments_on_request_id"
    t.index ["user_id"], name: "index_approval_comments_on_user_id"
  end

  create_table "approval_items", id: :serial, force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "resource_id"
    t.string "resource_type", null: false
    t.string "event", null: false
    t.text "params"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_approval_items_on_discarded_at"
    t.index ["external_id"], name: "index_approval_items_on_external_id"
    t.index ["request_id"], name: "index_approval_items_on_request_id"
    t.index ["resource_id", "resource_type"], name: "index_approval_items_on_resource_id_and_resource_type"
  end

  create_table "approval_matches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.bigint "approver_id"
    t.string "approver_role"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_approval_matches_on_approver_id"
    t.index ["approver_role"], name: "index_approval_matches_on_approver_role"
    t.index ["discarded_at"], name: "index_approval_matches_on_discarded_at"
    t.index ["external_id"], name: "index_approval_matches_on_external_id"
    t.index ["role_id"], name: "index_approval_matches_on_role_id"
    t.index ["user_id"], name: "index_approval_matches_on_user_id"
  end

  create_table "approval_requests", id: :serial, force: :cascade do |t|
    t.integer "request_user_id", null: false
    t.integer "respond_user_id"
    t.integer "state", limit: 2, default: 0, null: false
    t.datetime "requested_at", null: false
    t.datetime "cancelled_at"
    t.datetime "approved_at"
    t.datetime "rejected_at"
    t.datetime "executed_at"
    t.integer "supervisor_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_approval_requests_on_discarded_at"
    t.index ["external_id"], name: "index_approval_requests_on_external_id"
    t.index ["request_user_id"], name: "index_approval_requests_on_request_user_id"
    t.index ["respond_user_id"], name: "index_approval_requests_on_respond_user_id"
    t.index ["state"], name: "index_approval_requests_on_state"
    t.index ["supervisor_id"], name: "index_approval_requests_on_supervisor_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "backup_fields", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.boolean "calculated"
    t.text "notes"
    t.string "field_case"
    t.string "status"
    t.bigint "backup_object_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backup_object_id"], name: "index_backup_fields_on_backup_object_id"
    t.index ["discarded_at"], name: "index_backup_fields_on_discarded_at"
    t.index ["external_id"], name: "index_backup_fields_on_external_id"
  end

  create_table "backup_infos", force: :cascade do |t|
    t.bigint "backup_field_id"
    t.text "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backup_field_id"], name: "index_backup_infos_on_backup_field_id"
    t.index ["discarded_at"], name: "index_backup_infos_on_discarded_at"
    t.index ["external_id"], name: "index_backup_infos_on_external_id"
  end

  create_table "backup_objects", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.boolean "custom"
    t.text "notes"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_backup_objects_on_discarded_at"
    t.index ["external_id"], name: "index_backup_objects_on_external_id"
  end

  create_table "backup_picklists", force: :cascade do |t|
    t.boolean "active"
    t.boolean "default_value"
    t.string "label"
    t.string "value"
    t.bigint "backup_field_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backup_field_id"], name: "index_backup_picklists_on_backup_field_id"
    t.index ["discarded_at"], name: "index_backup_picklists_on_discarded_at"
    t.index ["external_id"], name: "index_backup_picklists_on_external_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "account_case"
    t.string "bank_name"
    t.string "account_number"
    t.date "certification_date"
    t.string "status"
    t.boolean "active"
    t.boolean "main"
    t.string "url_token"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "specific_use"
    t.index ["discarded_at"], name: "index_bank_accounts_on_discarded_at"
    t.index ["external_id"], name: "index_bank_accounts_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_bank_accounts_on_resource_type_and_resource_id"
  end

  create_table "batch_details", force: :cascade do |t|
    t.bigint "isa_id"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "error_text"
    t.text "error_backlog"
    t.bigint "payment_batch_id"
    t.index ["discarded_at"], name: "index_batch_details_on_discarded_at"
    t.index ["external_id"], name: "index_batch_details_on_external_id"
    t.index ["isa_id"], name: "index_batch_details_on_isa_id"
    t.index ["payment_batch_id"], name: "index_batch_details_on_payment_batch_id"
  end

  create_table "bff_questions", force: :cascade do |t|
    t.string "status"
    t.string "acacemic_year"
    t.string "citizenship_status"
    t.boolean "pre_approved"
    t.boolean "applied_federal"
    t.string "term_applying_for"
    t.bigint "application_id"
    t.boolean "authorized_to_work"
    t.date "visa_expiration_date"
    t.string "visa_case"
    t.boolean "isa_to_pay_deposit"
    t.boolean "scolarship_for_funded_program"
    t.boolean "us_or_mexico_program"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["application_id"], name: "index_bff_questions_on_application_id"
    t.index ["discarded_at"], name: "index_bff_questions_on_discarded_at"
    t.index ["external_id"], name: "index_bff_questions_on_external_id"
    t.index ["user_id"], name: "index_bff_questions_on_user_id"
  end

  create_table "billing_document_details", force: :cascade do |t|
    t.bigint "billing_document_detail_id"
    t.string "status"
    t.integer "year"
    t.integer "month"
    t.float "payment_equivalency"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "isa_id"
    t.string "detail_case"
    t.date "reference_date"
    t.string "currency"
    t.bigint "payment_agreement_id"
    t.float "applied_value"
    t.float "equivalency_covered"
    t.index ["applied_value"], name: "index_billing_document_details_on_applied_value"
    t.index ["billing_document_detail_id"], name: "index_billing_document_details_on_billing_document_detail_id"
    t.index ["detail_case"], name: "index_billing_document_details_on_detail_case"
    t.index ["discarded_at"], name: "index_billing_document_details_on_discarded_at"
    t.index ["equivalency_covered"], name: "index_billing_document_details_on_equivalency_covered"
    t.index ["external_id"], name: "index_billing_document_details_on_external_id"
    t.index ["isa_id"], name: "index_billing_document_details_on_isa_id"
    t.index ["month"], name: "index_billing_document_details_on_month"
    t.index ["payment_agreement_id"], name: "index_billing_document_details_on_payment_agreement_id"
    t.index ["reference_date"], name: "index_billing_document_details_on_reference_date"
    t.index ["status"], name: "index_billing_document_details_on_status"
    t.index ["value"], name: "index_billing_document_details_on_value"
    t.index ["year"], name: "index_billing_document_details_on_year"
  end

  create_table "billing_document_matches", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "billing_document_detail_id"
    t.index ["billing_document_detail_id"], name: "index_billing_document_matches_on_billing_document_detail_id"
    t.index ["discarded_at"], name: "index_billing_document_matches_on_discarded_at"
    t.index ["external_id"], name: "index_billing_document_matches_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_billing_document_matches_on_resource_type_and_resource_id"
  end

  create_table "billing_documents", force: :cascade do |t|
    t.bigint "isa_id"
    t.float "value"
    t.string "status"
    t.date "due_to_date"
    t.float "payment_weight"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_batch_id"
    t.integer "year"
    t.integer "month"
    t.date "reference_date"
    t.float "income_value"
    t.string "income_case"
    t.float "percentage_value"
    t.string "percentage_case"
    t.float "tax"
    t.float "base"
    t.boolean "visible_for_student"
    t.boolean "active"
    t.float "applied_value"
    t.index ["active"], name: "index_billing_documents_on_active"
    t.index ["applied_value"], name: "index_billing_documents_on_applied_value"
    t.index ["discarded_at"], name: "index_billing_documents_on_discarded_at"
    t.index ["due_to_date"], name: "index_billing_documents_on_due_to_date"
    t.index ["external_id"], name: "index_billing_documents_on_external_id"
    t.index ["isa_id"], name: "index_billing_documents_on_isa_id"
    t.index ["month"], name: "index_billing_documents_on_month"
    t.index ["payment_batch_id"], name: "index_billing_documents_on_payment_batch_id"
    t.index ["reference_date"], name: "index_billing_documents_on_reference_date"
    t.index ["status"], name: "index_billing_documents_on_status"
    t.index ["value"], name: "index_billing_documents_on_value"
    t.index ["year"], name: "index_billing_documents_on_year"
  end

  create_table "bizdev_businesses", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "priority"
    t.bigint "leader_id"
    t.bigint "coleader_id"
    t.date "expected_closing_date"
    t.string "phase"
    t.float "expected_revenue"
    t.float "expected_expenses"
    t.float "expected_margin"
    t.float "expected_cf"
    t.string "expected_risk"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.bigint "bizdev_business_id"
    t.string "general_status"
    t.string "currency"
    t.date "first_conctact_date"
    t.string "referenced_by"
    t.string "source"
    t.date "initial_contact_date"
    t.bigint "original_idea_id"
    t.index ["bizdev_business_id"], name: "index_bizdev_businesses_on_bizdev_business_id"
    t.index ["coleader_id"], name: "index_bizdev_businesses_on_coleader_id"
    t.index ["created_by_id"], name: "index_bizdev_businesses_on_created_by_id"
    t.index ["discarded_at"], name: "index_bizdev_businesses_on_discarded_at"
    t.index ["external_id"], name: "index_bizdev_businesses_on_external_id"
    t.index ["leader_id"], name: "index_bizdev_businesses_on_leader_id"
    t.index ["original_idea_id"], name: "index_bizdev_businesses_on_original_idea_id"
  end

  create_table "bizdev_operations", force: :cascade do |t|
    t.date "start_date"
    t.date "expected_end_date"
    t.bigint "leader_id"
    t.bigint "coleader_id"
    t.bigint "bizdev_business_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "technology_phase"
    t.string "operations_phase"
    t.string "legal_phase"
    t.string "research_phase"
    t.string "financial_phase"
    t.bigint "created_by_id"
    t.index ["bizdev_business_id"], name: "index_bizdev_operations_on_bizdev_business_id"
    t.index ["coleader_id"], name: "index_bizdev_operations_on_coleader_id"
    t.index ["created_by_id"], name: "index_bizdev_operations_on_created_by_id"
    t.index ["discarded_at"], name: "index_bizdev_operations_on_discarded_at"
    t.index ["external_id"], name: "index_bizdev_operations_on_external_id"
    t.index ["leader_id"], name: "index_bizdev_operations_on_leader_id"
  end

  create_table "black_rock_data", force: :cascade do |t|
    t.integer "number_of_children"
    t.integer "people_in_charge"
    t.string "dependent_on"
    t.string "working"
    t.string "reasons_to_apply"
    t.integer "guardian_income"
    t.string "guardian_income_origin"
    t.string "family_income_level"
    t.text "how_pandemic_affect"
    t.string "how_know_about_benefit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.text "fulfillment"
    t.index ["user_id"], name: "index_black_rock_data_on_user_id"
  end

  create_table "cancellation_configs", force: :cascade do |t|
    t.string "record_type"
    t.bigint "fund_id"
    t.string "cancellation_type"
    t.float "minimum_grade"
    t.float "maximum_grande"
    t.float "cancellation_percentage"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ejecution_type"
    t.float "max_general"
    t.float "social_work_hours"
    t.float "certified_work_months"
    t.index ["discarded_at"], name: "index_cancellation_configs_on_discarded_at"
    t.index ["external_id"], name: "index_cancellation_configs_on_external_id"
    t.index ["fund_id"], name: "index_cancellation_configs_on_fund_id"
  end

  create_table "cancellation_requests", force: :cascade do |t|
    t.float "term_gpa"
    t.bigint "disbursement_id"
    t.float "final_gpa"
    t.string "term"
    t.string "status"
    t.bigint "application_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "social_hours"
    t.string "company_name"
    t.date "company_start_date"
    t.date "company_end_date"
    t.bigint "isa_id"
    t.date "graduation_date"
    t.index ["application_id"], name: "index_cancellation_requests_on_application_id"
    t.index ["disbursement_id"], name: "index_cancellation_requests_on_disbursement_id"
    t.index ["discarded_at"], name: "index_cancellation_requests_on_discarded_at"
    t.index ["external_id"], name: "index_cancellation_requests_on_external_id"
    t.index ["isa_id"], name: "index_cancellation_requests_on_isa_id"
  end

  create_table "check_fields", force: :cascade do |t|
    t.bigint "check_object_id"
    t.string "name"
    t.string "label"
    t.float "nil_percentage"
    t.boolean "calculated"
    t.string "field_case"
    t.text "notes"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_object_id"], name: "index_check_fields_on_check_object_id"
    t.index ["discarded_at"], name: "index_check_fields_on_discarded_at"
    t.index ["external_id"], name: "index_check_fields_on_external_id"
  end

  create_table "check_modes", force: :cascade do |t|
    t.bigint "check_field_id"
    t.string "label"
    t.integer "frequency"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_field_id"], name: "index_check_modes_on_check_field_id"
    t.index ["discarded_at"], name: "index_check_modes_on_discarded_at"
    t.index ["external_id"], name: "index_check_modes_on_external_id"
  end

  create_table "check_objects", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.boolean "custom"
    t.integer "rows"
    t.boolean "migrate"
    t.text "notes"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_check_objects_on_discarded_at"
    t.index ["external_id"], name: "index_check_objects_on_external_id"
  end

  create_table "children", force: :cascade do |t|
    t.date "birthday"
    t.string "gender"
    t.string "academic_level"
    t.string "name"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_children_on_discarded_at"
    t.index ["external_id"], name: "index_children_on_external_id"
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "clusters", force: :cascade do |t|
    t.string "cluster_case"
    t.string "value"
    t.bigint "major_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["cluster_case"], name: "index_clusters_on_cluster_case"
    t.index ["discarded_at"], name: "index_clusters_on_discarded_at"
    t.index ["external_id"], name: "index_clusters_on_external_id"
    t.index ["major_id"], name: "index_clusters_on_major_id"
    t.index ["value"], name: "index_clusters_on_value"
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stage"
    t.string "contact_person"
    t.string "communication_chanel"
    t.string "action"
    t.string "case"
    t.string "result"
    t.string "value"
    t.date "following_date"
    t.string "reason_not_payment"
    t.text "comments"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "affiliation_status"
    t.string "system"
    t.string "affiliation_type"
    t.string "agreed_value"
    t.string "no_payment_reason"
    t.bigint "owner_id"
    t.index ["discarded_at"], name: "index_collections_on_discarded_at"
    t.index ["external_id"], name: "index_collections_on_external_id"
    t.index ["owner_id"], name: "index_collections_on_owner_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "communication_cases", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_communication_cases_on_company_id"
    t.index ["discarded_at"], name: "index_communication_cases_on_discarded_at"
    t.index ["external_id"], name: "index_communication_cases_on_external_id"
  end

  create_table "communication_footers", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_communication_footers_on_company_id"
    t.index ["discarded_at"], name: "index_communication_footers_on_discarded_at"
    t.index ["external_id"], name: "index_communication_footers_on_external_id"
  end

  create_table "communication_headers", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_communication_headers_on_company_id"
    t.index ["discarded_at"], name: "index_communication_headers_on_discarded_at"
    t.index ["external_id"], name: "index_communication_headers_on_external_id"
  end

  create_table "communication_templates", force: :cascade do |t|
    t.string "title"
    t.string "subject"
    t.text "body"
    t.bigint "company_id"
    t.bigint "communication_header_id"
    t.bigint "communication_footer_id"
    t.string "language"
    t.bigint "communication_case_id"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["communication_case_id"], name: "index_communication_templates_on_communication_case_id"
    t.index ["communication_footer_id"], name: "index_communication_templates_on_communication_footer_id"
    t.index ["communication_header_id"], name: "index_communication_templates_on_communication_header_id"
    t.index ["company_id"], name: "index_communication_templates_on_company_id"
    t.index ["discarded_at"], name: "index_communication_templates_on_discarded_at"
    t.index ["external_id"], name: "index_communication_templates_on_external_id"
    t.index ["language"], name: "index_communication_templates_on_language"
    t.index ["status"], name: "index_communication_templates_on_status"
  end

  create_table "communication_users", force: :cascade do |t|
    t.bigint "user_id"
    t.string "from_field"
    t.string "to_field"
    t.string "subject"
    t.text "body"
    t.boolean "read_field"
    t.string "category"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_communication_users_on_discarded_at"
    t.index ["external_id"], name: "index_communication_users_on_external_id"
    t.index ["user_id"], name: "index_communication_users_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id"
    t.bigint "country_id"
    t.string "status", null: false
    t.string "url", null: false
    t.string "default_language", null: false
    t.string "timezone", null: false
    t.string "main_title"
    t.string "slogan"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "credit_check_disclosure_id"
    t.integer "min_self_representation_age"
    t.boolean "automatic_proposal_display"
    t.bigint "income_origination_id"
    t.bigint "origination_funded_major_id"
    t.integer "default_months"
    t.text "final_origination_text"
    t.boolean "custom_origination_end", default: true
    t.string "name_for_gateway"
    t.string "company_legal_id"
    t.float "min_unid_collection"
    t.boolean "show_in_home", default: true
    t.index ["company_id"], name: "index_companies_on_company_id"
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["credit_check_disclosure_id"], name: "index_companies_on_credit_check_disclosure_id"
    t.index ["default_language"], name: "index_companies_on_default_language"
    t.index ["discarded_at"], name: "index_companies_on_discarded_at"
    t.index ["external_id"], name: "index_companies_on_external_id"
    t.index ["income_origination_id"], name: "index_companies_on_income_origination_id"
    t.index ["name"], name: "index_companies_on_name"
    t.index ["origination_funded_major_id"], name: "index_companies_on_origination_funded_major_id"
    t.index ["timezone"], name: "index_companies_on_timezone"
    t.index ["url"], name: "index_companies_on_url"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "complementary_activities", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "workshop"
    t.boolean "mentorship"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_complementary_activities_on_discarded_at"
    t.index ["external_id"], name: "index_complementary_activities_on_external_id"
    t.index ["user_id"], name: "index_complementary_activities_on_user_id"
  end

  create_table "complementary_originations", force: :cascade do |t|
    t.bigint "funding_opportunity_id"
    t.bigint "diploma_delivery_id"
    t.bigint "identification_document_id"
    t.bigint "grades_id"
    t.bigint "academic_stop_id"
    t.bigint "financial_adjust_id"
    t.bigint "conciliation_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_stop_id"], name: "index_complementary_originations_on_academic_stop_id"
    t.index ["conciliation_id"], name: "index_complementary_originations_on_conciliation_id"
    t.index ["diploma_delivery_id"], name: "index_complementary_originations_on_diploma_delivery_id"
    t.index ["discarded_at"], name: "index_complementary_originations_on_discarded_at"
    t.index ["external_id"], name: "index_complementary_originations_on_external_id"
    t.index ["financial_adjust_id"], name: "index_complementary_originations_on_financial_adjust_id"
    t.index ["funding_opportunity_id"], name: "index_complementary_originations_on_funding_opportunity_id"
    t.index ["grades_id"], name: "index_complementary_originations_on_grades_id"
    t.index ["identification_document_id"], name: "index_complementary_originations_on_identification_document_id"
  end

  create_table "conciliation_informations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "year"
    t.float "total_income"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "isa_id"
    t.bigint "payment_agreement_id"
    t.string "status"
    t.bigint "income_information_id"
    t.index ["discarded_at"], name: "index_conciliation_informations_on_discarded_at"
    t.index ["external_id"], name: "index_conciliation_informations_on_external_id"
    t.index ["income_information_id"], name: "index_conciliation_informations_on_income_information_id"
    t.index ["isa_id"], name: "index_conciliation_informations_on_isa_id"
    t.index ["payment_agreement_id"], name: "index_conciliation_informations_on_payment_agreement_id"
  end

  create_table "condonations", force: :cascade do |t|
    t.bigint "disbursement_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "cancellation_case"
    t.float "cancelation_value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "index_condonations_on_disbursement_id"
    t.index ["discarded_at"], name: "index_condonations_on_discarded_at"
    t.index ["external_id"], name: "index_condonations_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_condonations_on_resource_type_and_resource_id"
  end

  create_table "contact_infos", force: :cascade do |t|
    t.string "area_code"
    t.string "phone"
    t.integer "extension_number"
    t.string "mobile"
    t.string "other_phone"
    t.string "secondary_email"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_email"
    t.string "whatsapp"
    t.index ["discarded_at"], name: "index_contact_infos_on_discarded_at"
    t.index ["external_id"], name: "index_contact_infos_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_contact_infos_on_resource_type_and_resource_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "terms"
    t.float "graduated_percentage"
    t.float "studying_percentage"
    t.float "nominal_payment"
    t.bigint "application_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_contracts_on_application_id"
    t.index ["discarded_at"], name: "index_contracts_on_discarded_at"
    t.index ["external_id"], name: "index_contracts_on_external_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.decimal "yearly_usury_rate"
    t.integer "round_up_to"
    t.string "currency"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "international_code"
    t.integer "legal_age"
    t.float "long_term_inflation", default: 3.0
    t.float "main_tax_value"
    t.boolean "show_in_home", default: true
    t.index ["discarded_at"], name: "index_countries_on_discarded_at"
    t.index ["external_id"], name: "index_countries_on_external_id"
    t.index ["name"], name: "index_countries_on_name"
  end

  create_table "covid_configs", force: :cascade do |t|
    t.bigint "fund_id"
    t.string "normal"
    t.string "due_date"
    t.string "payment_agreement"
    t.string "custom_adjustment"
    t.string "no_payment"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_covid_configs_on_discarded_at"
    t.index ["external_id"], name: "index_covid_configs_on_external_id"
    t.index ["fund_id"], name: "index_covid_configs_on_fund_id"
  end

  create_table "covid_emergencies", force: :cascade do |t|
    t.bigint "billing_document_id"
    t.string "option"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "details"
    t.boolean "done"
    t.index ["billing_document_id"], name: "index_covid_emergencies_on_billing_document_id"
    t.index ["discarded_at"], name: "index_covid_emergencies_on_discarded_at"
    t.index ["external_id"], name: "index_covid_emergencies_on_external_id"
  end

  create_table "credit_history_checks", force: :cascade do |t|
    t.string "check_result"
    t.float "funding_capacity"
    t.float "indebtedness_level"
    t.float "credit_score"
    t.float "financial_duties"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_credit_history_checks_on_discarded_at"
    t.index ["external_id"], name: "index_credit_history_checks_on_external_id"
    t.index ["user_id"], name: "index_credit_history_checks_on_user_id"
  end

  create_table "curreny_histories", force: :cascade do |t|
    t.string "currency_base"
    t.string "currency_target"
    t.date "date"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_curreny_histories_on_discarded_at"
    t.index ["external_id"], name: "index_curreny_histories_on_external_id"
  end

  create_table "custom_disbursements", force: :cascade do |t|
    t.bigint "modeling_id"
    t.string "currency"
    t.string "disbursement_case"
    t.float "student_value"
    t.float "company_value"
    t.date "forcasted_date"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target_email"
    t.string "token"
    t.bigint "funding_token_id"
    t.index ["discarded_at"], name: "index_custom_disbursements_on_discarded_at"
    t.index ["external_id"], name: "index_custom_disbursements_on_external_id"
    t.index ["funding_token_id"], name: "index_custom_disbursements_on_funding_token_id"
    t.index ["modeling_id"], name: "index_custom_disbursements_on_modeling_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.string "name"
    t.string "fixed_report"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "table_case"
    t.index ["discarded_at"], name: "index_dashboards_on_discarded_at"
    t.index ["external_id"], name: "index_dashboards_on_external_id"
  end

  create_table "default_matrices", force: :cascade do |t|
    t.bigint "country_id"
    t.string "fund_case"
    t.float "probability"
    t.integer "number"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_default_matrices_on_country_id"
    t.index ["discarded_at"], name: "index_default_matrices_on_discarded_at"
    t.index ["external_id"], name: "index_default_matrices_on_external_id"
  end

  create_table "disbursement_cancellations", force: :cascade do |t|
    t.bigint "disbursement_id"
    t.string "status"
    t.text "notes"
    t.string "cancellation_case"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cancellation_config_id"
    t.index ["cancellation_config_id"], name: "index_disbursement_cancellations_on_cancellation_config_id"
    t.index ["disbursement_id"], name: "index_disbursement_cancellations_on_disbursement_id"
    t.index ["discarded_at"], name: "index_disbursement_cancellations_on_discarded_at"
    t.index ["external_id"], name: "index_disbursement_cancellations_on_external_id"
  end

  create_table "disbursement_matches", force: :cascade do |t|
    t.bigint "disbursement_id"
    t.bigint "disbursement_request_id"
    t.float "values"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "index_disbursement_matches_on_disbursement_id"
    t.index ["disbursement_request_id"], name: "index_disbursement_matches_on_disbursement_request_id"
    t.index ["discarded_at"], name: "index_disbursement_matches_on_discarded_at"
    t.index ["external_id"], name: "index_disbursement_matches_on_external_id"
  end

  create_table "disbursement_originations", force: :cascade do |t|
    t.integer "max_request_by_disbursement"
    t.float "percentage_previous_tuition"
    t.float "percentage_next_tuition"
    t.float "percentage_previous_living_expenses"
    t.float "percentage_next_living_expenses"
    t.bigint "company_id"
    t.bigint "origination_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "origin_living_id"
    t.bigint "review_tuition_id"
    t.bigint "review_living_id"
    t.bigint "bonus_origination_id"
    t.bigint "funding_opportunity_id"
    t.integer "emergency_living_expenses_origination_id"
    t.index ["bonus_origination_id"], name: "index_disbursement_originations_on_bonus_origination_id"
    t.index ["company_id"], name: "index_disbursement_originations_on_company_id"
    t.index ["discarded_at"], name: "index_disbursement_originations_on_discarded_at"
    t.index ["external_id"], name: "index_disbursement_originations_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_disbursement_originations_on_funding_opportunity_id"
    t.index ["origin_living_id"], name: "index_disbursement_originations_on_origin_living_id"
    t.index ["origination_id"], name: "index_disbursement_originations_on_origination_id"
    t.index ["review_living_id"], name: "index_disbursement_originations_on_review_living_id"
    t.index ["review_tuition_id"], name: "index_disbursement_originations_on_review_tuition_id"
  end

  create_table "disbursement_payments", force: :cascade do |t|
    t.bigint "disbursement_id"
    t.bigint "disbursement_request_id"
    t.float "value"
    t.string "payment_case"
    t.bigint "bank_account_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.boolean "request_support"
    t.string "status"
    t.date "payment_date"
    t.boolean "account_receivable", default: false
    t.index ["bank_account_id"], name: "index_disbursement_payments_on_bank_account_id"
    t.index ["disbursement_id"], name: "index_disbursement_payments_on_disbursement_id"
    t.index ["disbursement_request_id"], name: "index_disbursement_payments_on_disbursement_request_id"
    t.index ["discarded_at"], name: "index_disbursement_payments_on_discarded_at"
    t.index ["external_id"], name: "index_disbursement_payments_on_external_id"
  end

  create_table "disbursement_requests", force: :cascade do |t|
    t.bigint "application_id"
    t.float "tuition_value"
    t.string "status"
    t.date "due_date"
    t.string "request_case"
    t.float "value_payed_by_student"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "tuition_funded_percentage"
    t.float "disbursement_value"
    t.boolean "living_expenses_check"
    t.float "living_expenses_value"
    t.string "disbursement_case"
    t.string "tuition_due_date_type"
    t.boolean "value_payed_by_student_check"
    t.string "payment_target"
    t.date "student_payment_date"
    t.string "student_payment_income_source"
    t.float "reimbursement_value"
    t.date "payment_date_to_institution"
    t.float "confirmed_value"
    t.string "term"
    t.index ["application_id"], name: "index_disbursement_requests_on_application_id"
    t.index ["discarded_at"], name: "index_disbursement_requests_on_discarded_at"
    t.index ["external_id"], name: "index_disbursement_requests_on_external_id"
  end

  create_table "disbursements", force: :cascade do |t|
    t.bigint "funding_option_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "currency"
    t.string "disbursement_case"
    t.float "student_value"
    t.float "company_value"
    t.date "forcasted_date"
    t.boolean "request_tuition_support"
    t.integer "disbursement_number"
    t.float "clearance_value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "application_id"
    t.bigint "student_academic_information_id"
    t.bigint "isa_id"
    t.string "stored_general_status"
    t.float "valuation_value"
    t.float "requested"
    t.float "approved"
    t.float "compromised"
    t.float "disbursed"
    t.float "disbursement_process"
    t.float "canceled"
    t.float "adjusted_student_value"
    t.float "payed_by_student"
    t.index ["application_id"], name: "index_disbursements_on_application_id"
    t.index ["disbursement_case"], name: "index_disbursements_on_disbursement_case"
    t.index ["discarded_at"], name: "index_disbursements_on_discarded_at"
    t.index ["external_id"], name: "index_disbursements_on_external_id"
    t.index ["forcasted_date"], name: "index_disbursements_on_forcasted_date"
    t.index ["funding_option_id"], name: "index_disbursements_on_funding_option_id"
    t.index ["isa_id"], name: "index_disbursements_on_isa_id"
    t.index ["resource_type", "resource_id"], name: "index_disbursements_on_resource_type_and_resource_id"
    t.index ["stored_general_status"], name: "index_disbursements_on_stored_general_status"
    t.index ["student_academic_information_id"], name: "index_disbursements_on_student_academic_information_id"
  end

  create_table "docs_faqs", force: :cascade do |t|
    t.bigint "docs_general_id"
    t.text "description"
    t.bigint "docs_faq_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_docs_faqs_on_discarded_at"
    t.index ["docs_faq_id"], name: "index_docs_faqs_on_docs_faq_id"
    t.index ["docs_general_id"], name: "index_docs_faqs_on_docs_general_id"
    t.index ["external_id"], name: "index_docs_faqs_on_external_id"
  end

  create_table "docs_fields", force: :cascade do |t|
    t.bigint "docs_general_id"
    t.string "field"
    t.text "description"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "object"
    t.index ["discarded_at"], name: "index_docs_fields_on_discarded_at"
    t.index ["docs_general_id"], name: "index_docs_fields_on_docs_general_id"
    t.index ["external_id"], name: "index_docs_fields_on_external_id"
  end

  create_table "docs_generals", force: :cascade do |t|
    t.text "description"
    t.string "language"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "controller"
    t.index ["discarded_at"], name: "index_docs_generals_on_discarded_at"
    t.index ["external_id"], name: "index_docs_generals_on_external_id"
  end

  create_table "docs_notes", force: :cascade do |t|
    t.bigint "docs_general_id"
    t.text "description"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_docs_notes_on_discarded_at"
    t.index ["docs_general_id"], name: "index_docs_notes_on_docs_general_id"
    t.index ["external_id"], name: "index_docs_notes_on_external_id"
    t.index ["user_id"], name: "index_docs_notes_on_user_id"
  end

  create_table "eligibility_usas", force: :cascade do |t|
    t.string "academic_year"
    t.boolean "fafsa"
    t.string "citizenship"
    t.boolean "preaproved"
    t.string "study_status"
    t.float "estimated_assistance"
    t.float "cost_attendance"
    t.bigint "application_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_eligibility_usas_on_application_id"
    t.index ["discarded_at"], name: "index_eligibility_usas_on_discarded_at"
    t.index ["external_id"], name: "index_eligibility_usas_on_external_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "controller"
    t.string "action"
    t.bigint "autor_id"
    t.string "status"
    t.string "title"
    t.text "body"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority"
    t.string "expected_impact"
    t.string "dificulty"
    t.string "category"
    t.index ["autor_id"], name: "index_feedbacks_on_autor_id"
    t.index ["discarded_at"], name: "index_feedbacks_on_discarded_at"
    t.index ["external_id"], name: "index_feedbacks_on_external_id"
  end

  create_table "form_attributes", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.bigint "form_field_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_form_attributes_on_discarded_at"
    t.index ["external_id"], name: "index_form_attributes_on_external_id"
    t.index ["form_field_id"], name: "index_form_attributes_on_form_field_id"
  end

  create_table "form_fields", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "order"
    t.integer "row"
    t.integer "grid"
    t.bigint "form_template_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "format"
    t.index ["discarded_at"], name: "index_form_fields_on_discarded_at"
    t.index ["external_id"], name: "index_form_fields_on_external_id"
    t.index ["form_template_id"], name: "index_form_fields_on_form_template_id"
    t.index ["grid"], name: "index_form_fields_on_grid"
    t.index ["name"], name: "index_form_fields_on_name"
    t.index ["order"], name: "index_form_fields_on_order"
    t.index ["row"], name: "index_form_fields_on_row"
    t.index ["status"], name: "index_form_fields_on_status"
  end

  create_table "form_inputs", force: :cascade do |t|
    t.bigint "form_field_id"
    t.string "input"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_form_inputs_on_discarded_at"
    t.index ["external_id"], name: "index_form_inputs_on_external_id"
    t.index ["form_field_id"], name: "index_form_inputs_on_form_field_id"
  end

  create_table "form_labels", force: :cascade do |t|
    t.string "label"
    t.string "language"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_form_labels_on_discarded_at"
    t.index ["external_id"], name: "index_form_labels_on_external_id"
    t.index ["language"], name: "index_form_labels_on_language"
    t.index ["resource_type", "resource_id"], name: "index_form_labels_on_resource_type_and_resource_id"
  end

  create_table "form_list_dbs", force: :cascade do |t|
    t.bigint "form_list_id"
    t.string "functionality"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_form_list_dbs_on_discarded_at"
    t.index ["external_id"], name: "index_form_list_dbs_on_external_id"
    t.index ["form_list_id"], name: "index_form_list_dbs_on_form_list_id"
  end

  create_table "form_list_values", force: :cascade do |t|
    t.string "value"
    t.bigint "form_list_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["discarded_at"], name: "index_form_list_values_on_discarded_at"
    t.index ["external_id"], name: "index_form_list_values_on_external_id"
    t.index ["form_list_id"], name: "index_form_list_values_on_form_list_id"
  end

  create_table "form_lists", force: :cascade do |t|
    t.string "case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case"], name: "index_form_lists_on_case"
    t.index ["discarded_at"], name: "index_form_lists_on_discarded_at"
    t.index ["external_id"], name: "index_form_lists_on_external_id"
  end

  create_table "form_templates", force: :cascade do |t|
    t.string "name", null: false
    t.string "object", null: false
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default"
    t.bigint "child_id"
    t.string "child_foreign_key"
    t.index ["child_id"], name: "index_form_templates_on_child_id"
    t.index ["default"], name: "index_form_templates_on_default"
    t.index ["discarded_at"], name: "index_form_templates_on_discarded_at"
    t.index ["external_id"], name: "index_form_templates_on_external_id"
    t.index ["name"], name: "index_form_templates_on_name", unique: true
    t.index ["object"], name: "index_form_templates_on_object"
  end

  create_table "fund_withdrawals", force: :cascade do |t|
    t.string "reason"
    t.text "description"
    t.bigint "isa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isa_id"], name: "index_fund_withdrawals_on_isa_id"
  end

  create_table "funding_disbursements", force: :cascade do |t|
    t.float "max_total_fundinding_value"
    t.float "max_funding_by_disbursement"
    t.float "growth_rate"
    t.string "disbursement_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "funding_opportunity_id"
    t.integer "max_funding_months"
    t.float "living_expenses_value"
    t.integer "living_expenses_periodicity"
    t.float "max_tuition_percentage"
    t.boolean "automatic_activation"
    t.index ["discarded_at"], name: "index_funding_disbursements_on_discarded_at"
    t.index ["external_id"], name: "index_funding_disbursements_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_funding_disbursements_on_funding_opportunity_id"
  end

  create_table "funding_needs", force: :cascade do |t|
    t.date "first_disbursement_date"
    t.integer "periodicity"
    t.integer "number_disbursements"
    t.float "value_required"
    t.bigint "student_academic_information_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_funding_needs_on_discarded_at"
    t.index ["external_id"], name: "index_funding_needs_on_external_id"
    t.index ["student_academic_information_id"], name: "index_funding_needs_on_student_academic_information_id"
  end

  create_table "funding_opportunities", force: :cascade do |t|
    t.string "name"
    t.bigint "fund_id"
    t.boolean "field_work_required"
    t.integer "available_places"
    t.string "status"
    t.date "start_date"
    t.date "close_date"
    t.decimal "budget"
    t.string "opportunity_type"
    t.bigint "eligibility_criteria_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "origination_id"
    t.bigint "modeling_id"
    t.bigint "contract_adult_id"
    t.bigint "contract_young_id"
    t.bigint "amendment_young_id"
    t.bigint "amendment_adult_id"
    t.integer "offer_validity_days"
    t.integer "cancellation_days"
    t.bigint "invite_template_id"
    t.boolean "bootcamp"
    t.date "test_period_end_date"
    t.boolean "full_room", default: false
    t.boolean "active_living_expenses", default: false
    t.boolean "emergency_black_rock", default: false
    t.boolean "dynamic_rate_cap", default: false
    t.boolean "show_tuition_table", default: true
    t.boolean "show_living_expenses_table", default: true
    t.integer "blackrock_ammendment_id"
    t.boolean "include_promissory_note", default: false
    t.integer "adult_promissory_note_id"
    t.integer "young_promissory_note_id"
    t.index ["amendment_adult_id"], name: "index_funding_opportunities_on_amendment_adult_id"
    t.index ["amendment_young_id"], name: "index_funding_opportunities_on_amendment_young_id"
    t.index ["contract_adult_id"], name: "index_funding_opportunities_on_contract_adult_id"
    t.index ["contract_young_id"], name: "index_funding_opportunities_on_contract_young_id"
    t.index ["discarded_at"], name: "index_funding_opportunities_on_discarded_at"
    t.index ["eligibility_criteria_id"], name: "index_funding_opportunities_on_eligibility_criteria_id"
    t.index ["external_id"], name: "index_funding_opportunities_on_external_id"
    t.index ["fund_id"], name: "index_funding_opportunities_on_fund_id"
    t.index ["invite_template_id"], name: "index_funding_opportunities_on_invite_template_id"
    t.index ["modeling_id"], name: "index_funding_opportunities_on_modeling_id"
    t.index ["origination_id"], name: "index_funding_opportunities_on_origination_id"
    t.index ["status"], name: "index_funding_opportunities_on_status"
  end

  create_table "funding_opportunity_invitations", force: :cascade do |t|
    t.bigint "funding_opportunity_id"
    t.string "name"
    t.string "target_email"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_funding_opportunity_invitations_on_discarded_at"
    t.index ["external_id"], name: "index_funding_opportunity_invitations_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_funding_opportunity_invitations_on_funding_opportunity_id"
  end

  create_table "funding_opportunity_teams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "funding_opportunity_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_funding_opportunity_teams_on_discarded_at"
    t.index ["external_id"], name: "index_funding_opportunity_teams_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_funding_opportunity_teams_on_funding_opportunity_id"
    t.index ["user_id"], name: "index_funding_opportunity_teams_on_user_id"
  end

  create_table "funding_option_configs", force: :cascade do |t|
    t.bigint "funding_option_id"
    t.string "name"
    t.integer "max_months"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "other_value"
    t.index ["discarded_at"], name: "index_funding_option_configs_on_discarded_at"
    t.index ["external_id"], name: "index_funding_option_configs_on_external_id"
    t.index ["funding_option_id"], name: "index_funding_option_configs_on_funding_option_id"
  end

  create_table "funding_option_disbursements", force: :cascade do |t|
    t.bigint "funding_option_id"
    t.bigint "disbursement_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "evaluation_value"
    t.index ["disbursement_id"], name: "index_funding_option_disbursements_on_disbursement_id"
    t.index ["discarded_at"], name: "index_funding_option_disbursements_on_discarded_at"
    t.index ["external_id"], name: "index_funding_option_disbursements_on_external_id"
    t.index ["funding_option_id"], name: "index_funding_option_disbursements_on_funding_option_id"
  end

  create_table "funding_option_statuses", force: :cascade do |t|
    t.bigint "funding_option_config_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_funding_option_statuses_on_discarded_at"
    t.index ["external_id"], name: "index_funding_option_statuses_on_external_id"
    t.index ["funding_option_config_id"], name: "index_funding_option_statuses_on_funding_option_config_id"
  end

  create_table "funding_options", force: :cascade do |t|
    t.float "percentage_student"
    t.float "percentage_graduated"
    t.integer "isa_term"
    t.date "offer_due_date"
    t.date "cancelation_due_date"
    t.date "acceptance_date"
    t.boolean "visible_to_student"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_id"
    t.string "target"
    t.float "target_value"
    t.string "model_status"
    t.bigint "modeling_fixed_condition_id"
    t.bigint "original_option_id"
    t.float "total_pending_disbursement"
    t.float "total_payed_disbursement"
    t.float "total_approved_disbursement"
    t.float "value_to_cap"
    t.float "cap_excess"
    t.float "value_to_cap_with_excess"
    t.float "xirr"
    t.index ["application_id"], name: "index_funding_options_on_application_id"
    t.index ["discarded_at"], name: "index_funding_options_on_discarded_at"
    t.index ["external_id"], name: "index_funding_options_on_external_id"
    t.index ["modeling_fixed_condition_id"], name: "index_funding_options_on_modeling_fixed_condition_id"
    t.index ["original_option_id"], name: "index_funding_options_on_original_option_id"
  end

  create_table "funding_tokens", force: :cascade do |t|
    t.bigint "funding_opportunity_id"
    t.string "token"
    t.string "token_status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "email_sent"
    t.string "target_email"
    t.string "name"
    t.bigint "student_token_batch_id"
    t.index ["discarded_at"], name: "index_funding_tokens_on_discarded_at"
    t.index ["external_id"], name: "index_funding_tokens_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_funding_tokens_on_funding_opportunity_id"
    t.index ["student_token_batch_id"], name: "index_funding_tokens_on_student_token_batch_id"
    t.index ["user_id"], name: "index_funding_tokens_on_user_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "name"
    t.bigint "fund_id"
    t.boolean "preapproval_by_investor"
    t.float "renewal_in_years"
    t.boolean "active"
    t.boolean "applies_taxes"
    t.integer "close_day"
    t.integer "timely_payment_day"
    t.date "start_date"
    t.date "close_date"
    t.integer "extension_periods"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "variable_grace_period"
    t.boolean "forcasted_salary_clause"
    t.string "payment_gateway_type"
    t.bigint "payment_gateway_id"
    t.boolean "conservative_salaries"
    t.float "hurdle"
    t.boolean "hurdle_taxes"
    t.float "bonus_min_score"
    t.float "bonus_value"
    t.boolean "automatic_variable_income"
    t.boolean "include_tuition_in_modeling", default: true
    t.bigint "cancellation_origination_id"
    t.bigint "conciliation_origination_id"
    t.bigint "graduation_cancellation_origination_id"
    t.float "min_conciliation"
    t.boolean "vat_for_all_payments"
    t.float "min_student_irr_for_vat"
    t.float "escrow_monthly_cost"
    t.float "aum_fund"
    t.float "rate_fo_return_saving_account"
    t.string "type_of_fund"
    t.boolean "conciliation"
    t.float "cap_rate"
    t.boolean "course_inscription"
    t.boolean "partial_scores"
    t.boolean "final_scores"
    t.bigint "student_financial_information_origination_id"
    t.integer "student_location_origination_id"
    t.integer "student_personal_information_origination_id"
    t.integer "student_contact_information_origination_id"
    t.integer "user_data_origination_id"
    t.integer "academic_stop_origination_id"
    t.integer "fund_withdrawal_origination_id"
    t.integer "bank_account_origination_id"
    t.integer "black_rock_origination_id"
    t.bigint "wompi_gateway_id"
    t.index ["cancellation_origination_id"], name: "index_funds_on_cancellation_origination_id"
    t.index ["company_id"], name: "index_funds_on_company_id"
    t.index ["conciliation_origination_id"], name: "index_funds_on_conciliation_origination_id"
    t.index ["discarded_at"], name: "index_funds_on_discarded_at"
    t.index ["external_id"], name: "index_funds_on_external_id"
    t.index ["fund_id"], name: "index_funds_on_fund_id"
    t.index ["graduation_cancellation_origination_id"], name: "index_funds_on_graduation_cancellation_origination_id"
    t.index ["name"], name: "index_funds_on_name"
    t.index ["payment_gateway_type", "payment_gateway_id"], name: "index_funds_on_payment_gateway_type_and_payment_gateway_id"
    t.index ["student_financial_information_origination_id"], name: "index_funds_on_student_financial_information_origination_id"
    t.index ["wompi_gateway_id"], name: "index_funds_on_wompi_gateway_id"
  end

  create_table "general_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "request_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_general_requests_on_discarded_at"
    t.index ["external_id"], name: "index_general_requests_on_external_id"
    t.index ["user_id"], name: "index_general_requests_on_user_id"
  end

  create_table "generate_from_files", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "target_object"
    t.string "status"
    t.string "notes"
    t.string "process"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_generate_from_files_on_discarded_at"
    t.index ["external_id"], name: "index_generate_from_files_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_generate_from_files_on_resource_type_and_resource_id"
  end

  create_table "generate_matches", force: :cascade do |t|
    t.bigint "generate_from_file_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_generate_matches_on_discarded_at"
    t.index ["external_id"], name: "index_generate_matches_on_external_id"
    t.index ["generate_from_file_id"], name: "index_generate_matches_on_generate_from_file_id"
    t.index ["resource_type", "resource_id"], name: "index_generate_matches_on_resource_type_and_resource_id"
  end

  create_table "geographies", force: :cascade do |t|
    t.string "label"
    t.string "value"
    t.bigint "geography_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_of_geography"
    t.index ["discarded_at"], name: "index_geographies_on_discarded_at"
    t.index ["external_id"], name: "index_geographies_on_external_id"
    t.index ["geography_id"], name: "index_geographies_on_geography_id"
  end

  create_table "geography_codes", force: :cascade do |t|
    t.string "type"
    t.string "value"
    t.bigint "geography_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_geography_codes_on_discarded_at"
    t.index ["external_id"], name: "index_geography_codes_on_external_id"
    t.index ["geography_id"], name: "index_geography_codes_on_geography_id"
  end

  create_table "healths", force: :cascade do |t|
    t.boolean "disability_check"
    t.boolean "Inpatient_check"
    t.boolean "emergency_room_check"
    t.boolean "consumption_of_narcotic_check"
    t.boolean "diseases_check"
    t.text "diseases_text"
    t.text "disability_text"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "health_coverage"
    t.string "health_ranking"
    t.string "diseases_other"
    t.index ["discarded_at"], name: "index_healths_on_discarded_at"
    t.index ["external_id"], name: "index_healths_on_external_id"
    t.index ["user_id"], name: "index_healths_on_user_id"
  end

  create_table "income_informations", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "city_id"
    t.bigint "state_id"
    t.string "company_name"
    t.string "position"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contract_case"
    t.date "start_date"
    t.float "fix_income"
    t.string "contact_email"
    t.string "sector"
    t.date "end_date"
    t.string "shift"
    t.string "email_supervisor"
    t.string "name_supervisor"
    t.string "position_supervisor"
    t.string "company_address"
    t.string "company_phone"
    t.float "variable_income"
    t.string "company_identification"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_supervisor"
    t.string "income_case"
    t.string "status"
    t.boolean "active"
    t.string "currency"
    t.boolean "active_check", default: true
    t.string "tier"
    t.string "area"
    t.boolean "related_with_studies", default: false
    t.string "operations_status"
    t.decimal "exchange_rates", default: "1.0"
    t.string "type_of_labor"
    t.string "job_pool"
    t.bigint "parent_id"
    t.boolean "presumptive_income", default: false
    t.index ["city_id"], name: "index_income_informations_on_city_id"
    t.index ["country_id"], name: "index_income_informations_on_country_id"
    t.index ["discarded_at"], name: "index_income_informations_on_discarded_at"
    t.index ["external_id"], name: "index_income_informations_on_external_id"
    t.index ["parent_id"], name: "index_income_informations_on_parent_id"
    t.index ["state_id"], name: "index_income_informations_on_state_id"
    t.index ["user_id"], name: "index_income_informations_on_user_id"
  end

  create_table "income_variable_incomes", force: :cascade do |t|
    t.bigint "income_information_id"
    t.float "value"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "billing_document_id"
    t.index ["billing_document_id"], name: "index_income_variable_incomes_on_billing_document_id"
    t.index ["discarded_at"], name: "index_income_variable_incomes_on_discarded_at"
    t.index ["external_id"], name: "index_income_variable_incomes_on_external_id"
    t.index ["income_information_id"], name: "index_income_variable_incomes_on_income_information_id"
  end

  create_table "indicator_cases", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.bigint "company_id"
    t.bigint "indicator_type_id"
    t.string "function"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_indicator_cases_on_company_id"
    t.index ["discarded_at"], name: "index_indicator_cases_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_cases_on_external_id"
    t.index ["indicator_type_id"], name: "index_indicator_cases_on_indicator_type_id"
  end

  create_table "indicator_histories", force: :cascade do |t|
    t.string "name"
    t.decimal "value"
    t.string "format"
    t.date "date"
    t.bigint "indicator_case_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_indicator_histories_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_histories_on_external_id"
    t.index ["indicator_case_id"], name: "index_indicator_histories_on_indicator_case_id"
  end

  create_table "indicator_inputs", force: :cascade do |t|
    t.bigint "source_id"
    t.bigint "destination_id"
    t.bigint "indicator_case_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_indicator_inputs_on_destination_id"
    t.index ["discarded_at"], name: "index_indicator_inputs_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_inputs_on_external_id"
    t.index ["indicator_case_id"], name: "index_indicator_inputs_on_indicator_case_id"
    t.index ["source_id"], name: "index_indicator_inputs_on_source_id"
  end

  create_table "indicator_references", force: :cascade do |t|
    t.string "model"
    t.string "field"
    t.string "filter"
    t.string "operator"
    t.bigint "indicator_case_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_indicator_references_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_references_on_external_id"
    t.index ["indicator_case_id"], name: "index_indicator_references_on_indicator_case_id"
  end

  create_table "indicator_repetitions", force: :cascade do |t|
    t.string "day"
    t.integer "time"
    t.bigint "indicator_case_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_indicator_repetitions_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_repetitions_on_external_id"
    t.index ["indicator_case_id"], name: "index_indicator_repetitions_on_indicator_case_id"
  end

  create_table "indicator_types", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "functionality"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_indicator_types_on_discarded_at"
    t.index ["external_id"], name: "index_indicator_types_on_external_id"
  end

  create_table "info_terpels", force: :cascade do |t|
    t.string "applicant_case"
    t.string "gas_station_case"
    t.string "gas_station_name"
    t.string "escuderia_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "country_id_id"
    t.bigint "city_id_id"
    t.bigint "state_id_id"
    t.string "company_name"
    t.string "position"
    t.string "contract_case"
    t.date "start_date"
    t.float "fix_income"
    t.date "end_date"
    t.string "shift"
    t.string "email_supervisor"
    t.string "name_supervisor"
    t.string "position_supervisor"
    t.string "company_phone"
    t.string "relationship"
    t.string "station_code"
    t.index ["city_id_id"], name: "index_info_terpels_on_city_id_id"
    t.index ["country_id_id"], name: "index_info_terpels_on_country_id_id"
    t.index ["discarded_at"], name: "index_info_terpels_on_discarded_at"
    t.index ["external_id"], name: "index_info_terpels_on_external_id"
    t.index ["state_id_id"], name: "index_info_terpels_on_state_id_id"
    t.index ["user_id"], name: "index_info_terpels_on_user_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "code"
    t.string "website"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_from_sf"
    t.string "legacy_type"
    t.string "internal_code"
    t.string "city_internal_code"
    t.string "state_internal_code"
    t.string "searcher_name"
    t.string "tax_identification_number"
    t.index ["code"], name: "index_institutions_on_code"
    t.index ["discarded_at"], name: "index_institutions_on_discarded_at"
    t.index ["external_id"], name: "index_institutions_on_external_id"
    t.index ["name"], name: "index_institutions_on_name"
    t.index ["status"], name: "index_institutions_on_status"
  end

  create_table "invest_committees", force: :cascade do |t|
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.string "status"
    t.bigint "company_id"
    t.string "name"
    t.bigint "funding_opportunity_id"
    t.index ["company_id"], name: "index_invest_committees_on_company_id"
    t.index ["discarded_at"], name: "index_invest_committees_on_discarded_at"
    t.index ["external_id"], name: "index_invest_committees_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_invest_committees_on_funding_opportunity_id"
  end

  create_table "investment_decisions", force: :cascade do |t|
    t.bigint "invest_committee_id"
    t.bigint "funding_option_id"
    t.bigint "user_id"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_investment_decisions_on_discarded_at"
    t.index ["external_id"], name: "index_investment_decisions_on_external_id"
    t.index ["funding_option_id"], name: "index_investment_decisions_on_funding_option_id"
    t.index ["invest_committee_id"], name: "index_investment_decisions_on_invest_committee_id"
    t.index ["user_id"], name: "index_investment_decisions_on_user_id"
  end

  create_table "ipcs", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.float "value"
    t.bigint "country_id"
    t.float "monthly_variation"
    t.float "annual_variation"
    t.float "cumulative_variation"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "target_date"
    t.index ["country_id"], name: "index_ipcs_on_country_id"
    t.index ["discarded_at"], name: "index_ipcs_on_discarded_at"
    t.index ["external_id"], name: "index_ipcs_on_external_id"
  end

  create_table "isa_amendment_disbursements", force: :cascade do |t|
    t.bigint "isa_amendment_id"
    t.bigint "disbursement_id"
    t.string "currency"
    t.string "disbursement_case"
    t.float "student_value"
    t.float "company_value"
    t.date "forcasted_date"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "index_isa_amendment_disbursements_on_disbursement_id"
    t.index ["discarded_at"], name: "index_isa_amendment_disbursements_on_discarded_at"
    t.index ["external_id"], name: "index_isa_amendment_disbursements_on_external_id"
    t.index ["isa_amendment_id"], name: "index_isa_amendment_disbursements_on_isa_amendment_id"
  end

  create_table "isa_amendments", force: :cascade do |t|
    t.bigint "isa_id"
    t.string "status"
    t.bigint "user_id"
    t.string "amendment_case"
    t.text "notes"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_id"
    t.index ["application_id"], name: "index_isa_amendments_on_application_id"
    t.index ["discarded_at"], name: "index_isa_amendments_on_discarded_at"
    t.index ["external_id"], name: "index_isa_amendments_on_external_id"
    t.index ["isa_id"], name: "index_isa_amendments_on_isa_id"
    t.index ["user_id"], name: "index_isa_amendments_on_user_id"
  end

  create_table "isa_statuses", force: :cascade do |t|
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "isa_id"
    t.string "status_case"
    t.string "phase"
    t.string "comment", default: ""
    t.index ["discarded_at"], name: "index_isa_statuses_on_discarded_at"
    t.index ["external_id"], name: "index_isa_statuses_on_external_id"
    t.index ["isa_id"], name: "index_isa_statuses_on_isa_id"
  end

  create_table "isas", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.bigint "funding_option_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "inflation_case"
    t.date "inflation_adjustment_date"
    t.string "stored_income_status"
    t.string "stored_payment_status"
    t.string "stored_general_status"
    t.string "currency"
    t.bigint "funding_opportunity_id"
    t.bigint "student_academic_information_id"
    t.float "repayment_total_number"
    t.float "repayment_payed_number"
    t.float "payment_to_finalize_isa"
    t.string "stored_employment_status"
    t.bigint "employment_status_collection_trigger_id"
    t.index ["discarded_at"], name: "index_isas_on_discarded_at"
    t.index ["employment_status_collection_trigger_id"], name: "index_isas_on_employment_status_collection_trigger_id"
    t.index ["external_id"], name: "index_isas_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_isas_on_funding_opportunity_id"
    t.index ["funding_option_id"], name: "index_isas_on_funding_option_id"
    t.index ["status"], name: "index_isas_on_status"
    t.index ["stored_general_status"], name: "index_isas_on_stored_general_status"
    t.index ["stored_income_status"], name: "index_isas_on_stored_income_status"
    t.index ["stored_payment_status"], name: "index_isas_on_stored_payment_status"
    t.index ["student_academic_information_id"], name: "index_isas_on_student_academic_information_id"
    t.index ["user_id"], name: "index_isas_on_user_id"
  end

  create_table "legacy_statuses", force: :cascade do |t|
    t.string "academic_status"
    t.string "general_status"
    t.string "payment_status"
    t.string "work_status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_legacy_statuses_on_discarded_at"
    t.index ["external_id"], name: "index_legacy_statuses_on_external_id"
  end

  create_table "legal_documents", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "document_type"
    t.string "access"
    t.string "status"
    t.string "validation_method"
    t.string "activation_method"
    t.string "language"
    t.bigint "legal_documents_id"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "validation"
    t.index ["company_id"], name: "index_legal_documents_on_company_id"
    t.index ["discarded_at"], name: "index_legal_documents_on_discarded_at"
    t.index ["external_id"], name: "index_legal_documents_on_external_id"
    t.index ["legal_documents_id"], name: "index_legal_documents_on_legal_documents_id"
  end

  create_table "legal_matches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "legal_document_id"
    t.string "validation_method"
    t.string "validation"
    t.string "answer"
    t.text "body"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "identity_check_text"
    t.string "signer_ip"
    t.string "status"
    t.bigint "application_id"
    t.boolean "pending_for_scan"
    t.boolean "send_email", default: true
    t.integer "parent_id"
    t.index ["application_id"], name: "index_legal_matches_on_application_id"
    t.index ["discarded_at"], name: "index_legal_matches_on_discarded_at"
    t.index ["external_id"], name: "index_legal_matches_on_external_id"
    t.index ["legal_document_id"], name: "index_legal_matches_on_legal_document_id"
    t.index ["resource_type", "resource_id"], name: "index_legal_matches_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_legal_matches_on_user_id"
  end

  create_table "list_inputs", force: :cascade do |t|
    t.bigint "form_list_id"
    t.string "input"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_list_inputs_on_discarded_at"
    t.index ["external_id"], name: "index_list_inputs_on_external_id"
    t.index ["form_list_id"], name: "index_list_inputs_on_form_list_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.bigint "state_id"
    t.bigint "city_id"
    t.string "zip_code"
    t.string "municipality"
    t.string "neighborhood"
    t.index ["city_id"], name: "index_locations_on_city_id"
    t.index ["country_id"], name: "index_locations_on_country_id"
    t.index ["discarded_at"], name: "index_locations_on_discarded_at"
    t.index ["external_id"], name: "index_locations_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_locations_on_resource_type_and_resource_id"
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "name"
    t.string "academic_level"
    t.string "status"
    t.bigint "institution_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_level"], name: "index_majors_on_academic_level"
    t.index ["discarded_at"], name: "index_majors_on_discarded_at"
    t.index ["external_id"], name: "index_majors_on_external_id"
    t.index ["institution_id"], name: "index_majors_on_institution_id"
    t.index ["name"], name: "index_majors_on_name"
    t.index ["status"], name: "index_majors_on_status"
  end

  create_table "mentory_empleability_invitations", force: :cascade do |t|
    t.boolean "accept_invitation", default: false
    t.boolean "empleability", default: false
    t.boolean "mentory", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mentory_empleability_invitations_on_user_id"
  end

  create_table "mercado_pago_gateways", force: :cascade do |t|
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "gateway_case", default: ""
    t.string "public_key", default: ""
    t.string "access_token", default: ""
    t.string "app_id", default: ""
    t.string "name", default: ""
    t.index ["company_id"], name: "index_mercado_pago_gateways_on_company_id"
    t.index ["discarded_at"], name: "index_mercado_pago_gateways_on_discarded_at"
    t.index ["external_id"], name: "index_mercado_pago_gateways_on_external_id"
  end

  create_table "mercado_pago_responses", force: :cascade do |t|
    t.string "merchant_order_id"
    t.string "status"
    t.string "collection_id"
    t.string "payment_id"
    t.string "external_id"
    t.string "payment_type"
    t.string "preference_id"
    t.string "site_id"
    t.string "processing_mode"
    t.string "merchant_account_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mercado_pago_transaction_id"
    t.string "authorization_code"
    t.string "currency_id"
    t.string "date_approved"
    t.string "payment_method"
    t.string "transaction_amount"
    t.string "status_detail"
    t.index ["discarded_at"], name: "index_mercado_pago_responses_on_discarded_at"
    t.index ["external_id"], name: "index_mercado_pago_responses_on_external_id"
    t.index ["mercado_pago_transaction_id"], name: "index_mercado_pago_responses_on_mercado_pago_transaction_id"
  end

  create_table "mercado_pago_transactions", force: :cascade do |t|
    t.string "payment_method"
    t.float "value"
    t.float "tax"
    t.float "base"
    t.bigint "billing_document_id"
    t.bigint "mercado_pago_gateway_id"
    t.string "status"
    t.string "ip_address"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billing_document_id"], name: "index_mercado_pago_transactions_on_billing_document_id"
    t.index ["discarded_at"], name: "index_mercado_pago_transactions_on_discarded_at"
    t.index ["external_id"], name: "index_mercado_pago_transactions_on_external_id"
    t.index ["mercado_pago_gateway_id"], name: "index_mercado_pago_transactions_on_mercado_pago_gateway_id"
  end

  create_table "migration_accumulations", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.string "name"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_migration_accumulations_on_discarded_at"
    t.index ["external_id"], name: "index_migration_accumulations_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_migration_accumulations_on_resource_type_and_resource_id"
  end

  create_table "migration_fields", force: :cascade do |t|
    t.string "sf_field"
    t.string "model_field"
    t.string "function_text"
    t.string "type_of_field"
    t.bigint "migration_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "object_reference"
    t.string "fixed_value"
    t.index ["discarded_at"], name: "index_migration_fields_on_discarded_at"
    t.index ["external_id"], name: "index_migration_fields_on_external_id"
    t.index ["migration_id"], name: "index_migration_fields_on_migration_id"
  end

  create_table "migration_jobs", force: :cascade do |t|
    t.bigint "migration_id"
    t.string "target_array"
    t.string "status"
    t.integer "target_record_number"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_migration_jobs_on_discarded_at"
    t.index ["external_id"], name: "index_migration_jobs_on_external_id"
    t.index ["migration_id"], name: "index_migration_jobs_on_migration_id"
  end

  create_table "migration_picklists", force: :cascade do |t|
    t.bigint "migration_field_id"
    t.string "sf_value"
    t.string "rails_value"
    t.string "label_spanish"
    t.string "label_english"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_migration_picklists_on_discarded_at"
    t.index ["external_id"], name: "index_migration_picklists_on_external_id"
    t.index ["migration_field_id"], name: "index_migration_picklists_on_migration_field_id"
  end

  create_table "migration_trackings", force: :cascade do |t|
    t.bigint "migration_job_id"
    t.integer "processed_records"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "backup"
    t.string "status"
    t.integer "adjust_migration"
    t.index ["discarded_at"], name: "index_migration_trackings_on_discarded_at"
    t.index ["external_id"], name: "index_migration_trackings_on_external_id"
    t.index ["migration_job_id"], name: "index_migration_trackings_on_migration_job_id"
  end

  create_table "migrations", force: :cascade do |t|
    t.string "result"
    t.string "notes"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "type_of_migration"
    t.string "sf_object"
    t.string "function_text"
    t.string "status"
    t.bigint "migration_id"
    t.string "rails_object"
    t.text "where_field"
    t.string "options"
    t.text "additional_fields"
    t.integer "target_number"
    t.integer "processed_records"
    t.index ["discarded_at"], name: "index_migrations_on_discarded_at"
    t.index ["external_id"], name: "index_migrations_on_external_id"
    t.index ["migration_id"], name: "index_migrations_on_migration_id"
  end

  create_table "migrations_backups", force: :cascade do |t|
    t.bigint "migration_id"
    t.text "backup"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["discarded_at"], name: "index_migrations_backups_on_discarded_at"
    t.index ["external_id"], name: "index_migrations_backups_on_external_id"
    t.index ["migration_id"], name: "index_migrations_backups_on_migration_id"
    t.index ["user_id"], name: "index_migrations_backups_on_user_id"
  end

  create_table "model_and_fields", force: :cascade do |t|
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_model_and_fields_on_discarded_at"
    t.index ["external_id"], name: "index_model_and_fields_on_external_id"
  end

  create_table "modeling_fees", force: :cascade do |t|
    t.string "fees"
    t.string "fee_name"
    t.string "fee_case"
    t.string "r_type_fixed"
    t.integer "fee_peridicity"
    t.boolean "fee_included_taxes"
    t.boolean "fee_inflation_adjustment"
    t.float "fee_iva"
    t.string "fee_who_pay"
    t.string "fee_target"
    t.float "fee_fixed_part"
    t.float "fee_variable_part"
    t.boolean "fee_cp"
    t.boolean "fee_rp"
    t.float "percentaje_fee_cp"
    t.float "percentaje_fee_rp"
    t.string "value_fee_start_fee_field"
    t.string "value_fee_end_fee_field"
    t.string "value_fee_unique_date_field"
    t.string "value_fee_variable_part_field"
    t.float "fee_fixed_adjustment"
    t.float "fee_another_tax"
    t.bigint "modeling_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "min_value"
    t.boolean "include_in_modeling", default: true
    t.index ["discarded_at"], name: "index_modeling_fees_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_fees_on_external_id"
    t.index ["modeling_id"], name: "index_modeling_fees_on_modeling_id"
  end

  create_table "modeling_fixed_conditions", force: :cascade do |t|
    t.float "graduated_percentage"
    t.integer "term"
    t.float "nominal_payment"
    t.string "cap_type"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "modeling_id"
    t.float "student_percentage"
    t.float "cap_value"
    t.integer "unemployment_months"
    t.integer "grace_period"
    t.float "threshold"
    t.index ["discarded_at"], name: "index_modeling_fixed_conditions_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_fixed_conditions_on_external_id"
    t.index ["modeling_id"], name: "index_modeling_fixed_conditions_on_modeling_id"
  end

  create_table "modeling_flow_details", force: :cascade do |t|
    t.bigint "modeling_flow_id"
    t.float "student_flow"
    t.float "fund_flow"
    t.float "investor_flow"
    t.date "modeling_date"
    t.float "default_probability"
    t.float "unemployent_probability"
    t.float "cap_value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_modeling_flow_details_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_flow_details_on_external_id"
    t.index ["modeling_flow_id"], name: "index_modeling_flow_details_on_modeling_flow_id"
  end

  create_table "modeling_flow_extras", force: :cascade do |t|
    t.integer "repayment_period"
    t.float "prob_p10"
    t.float "prob_p20"
    t.float "prob_p30"
    t.float "prob_p40"
    t.float "prob_p50"
    t.float "prob_p60"
    t.float "prob_p70"
    t.float "prob_p80"
    t.float "prob_p90"
    t.float "repay_p10"
    t.float "repay_p20"
    t.float "repay_p30"
    t.float "repay_p40"
    t.float "repay_p50"
    t.float "repay_p60"
    t.float "repay_p70"
    t.float "repay_p80"
    t.float "repay_p90"
    t.float "culture_payment"
    t.float "real_collection"
    t.float "growth_p10"
    t.float "growth_p20"
    t.float "growth_p30"
    t.float "growth_p40"
    t.float "growth_p50"
    t.float "growth_p60"
    t.float "growth_p70"
    t.float "growth_p80"
    t.float "growth_p90"
    t.float "risk_adjustment"
    t.float "outflows"
    t.float "tuition"
    t.float "living_expenses"
    t.float "Repayments"
    t.float "inflows"
    t.float "fees"
    t.float "taxes"
    t.float "hurdle"
    t.float "pv_target_flow"
    t.float "cumulative_pv_target_flow"
    t.float "adjustment"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "modeling_flow_detail_id"
    t.index ["discarded_at"], name: "index_modeling_flow_extras_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_flow_extras_on_external_id"
    t.index ["modeling_flow_detail_id"], name: "index_modeling_flow_extras_on_modeling_flow_detail_id"
  end

  create_table "modeling_flow_fees", force: :cascade do |t|
    t.float "detail_fee"
    t.float "tax"
    t.bigint "modeling_fee_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "modeling_flow_detail_id"
    t.index ["discarded_at"], name: "index_modeling_flow_fees_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_flow_fees_on_external_id"
    t.index ["modeling_fee_id"], name: "index_modeling_flow_fees_on_modeling_fee_id"
    t.index ["modeling_flow_detail_id"], name: "index_modeling_flow_fees_on_modeling_flow_detail_id"
  end

  create_table "modeling_flow_summaries", force: :cascade do |t|
    t.bigint "modeling_flow_id"
    t.float "desembolsos"
    t.float "repagos"
    t.float "retorno"
    t.float "comisiones"
    t.float "upper_factor"
    t.float "lower_factor"
    t.float "middle_factor"
    t.string "step"
    t.string "algorithm"
    t.float "row_cashflow"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_modeling_flow_summaries_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_flow_summaries_on_external_id"
    t.index ["modeling_flow_id"], name: "index_modeling_flow_summaries_on_modeling_flow_id"
  end

  create_table "modeling_flows", force: :cascade do |t|
    t.bigint "modeling_id"
    t.bigint "funding_option_id"
    t.string "flow_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.integer "month"
    t.bigint "valuation_history_id"
    t.index ["discarded_at"], name: "index_modeling_flows_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_flows_on_external_id"
    t.index ["funding_option_id"], name: "index_modeling_flows_on_funding_option_id"
    t.index ["modeling_id"], name: "index_modeling_flows_on_modeling_id"
    t.index ["valuation_history_id"], name: "index_modeling_flows_on_valuation_history_id"
  end

  create_table "modeling_main_sencibilities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_modeling_main_sencibilities_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_main_sencibilities_on_external_id"
  end

  create_table "modeling_matches", force: :cascade do |t|
    t.bigint "application_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "status"
    t.index ["application_id"], name: "index_modeling_matches_on_application_id"
    t.index ["discarded_at"], name: "index_modeling_matches_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_matches_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_modeling_matches_on_resource_type_and_resource_id"
  end

  create_table "modeling_sencibilities", force: :cascade do |t|
    t.float "delta_default"
    t.float "delta_unemployment"
    t.float "delta_dropout"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "modeling_main_sencibility_id"
    t.index ["discarded_at"], name: "index_modeling_sencibilities_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_sencibilities_on_external_id"
    t.index ["modeling_main_sencibility_id"], name: "index_modeling_sencibilities_on_modeling_main_sencibility_id"
  end

  create_table "modeling_sencibility_details", force: :cascade do |t|
    t.bigint "modeling_sencibility_id"
    t.bigint "funding_option_id"
    t.integer "term"
    t.float "study_percentage"
    t.float "graduated_percentage"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.float "total_disbursement"
    t.text "log_info"
    t.index ["discarded_at"], name: "index_modeling_sencibility_details_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_sencibility_details_on_external_id"
    t.index ["funding_option_id"], name: "index_modeling_sencibility_details_on_funding_option_id"
    t.index ["modeling_sencibility_id"], name: "index_modeling_sencibility_details_on_modeling_sencibility_id"
  end

  create_table "modeling_variables", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "research_model_info_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_modeling_variables_on_discarded_at"
    t.index ["external_id"], name: "index_modeling_variables_on_external_id"
    t.index ["research_model_info_id"], name: "index_modeling_variables_on_research_model_info_id"
    t.index ["user_id"], name: "index_modeling_variables_on_user_id"
  end

  create_table "modelings", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "modeling_case"
    t.float "max_percentage_study"
    t.float "max_percentage_graduated"
    t.boolean "custom_disbursements"
    t.bigint "research_process_id"
    t.float "target_rate"
    t.string "target_case"
    t.boolean "visible_to_student"
    t.float "delta_default", default: 0.0
    t.float "delta_dropout", default: 0.0
    t.float "delta_unemployment", default: 0.0
    t.index ["discarded_at"], name: "index_modelings_on_discarded_at"
    t.index ["external_id"], name: "index_modelings_on_external_id"
    t.index ["research_process_id"], name: "index_modelings_on_research_process_id"
  end

  create_table "modelint_flow_extras", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "extra_case"
    t.string "extra_value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_modelint_flow_extras_on_discarded_at"
    t.index ["external_id"], name: "index_modelint_flow_extras_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_modelint_flow_extras_on_resource_type_and_resource_id"
  end

  create_table "multiple_choices", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "value"
    t.string "field"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_multiple_choices_on_discarded_at"
    t.index ["external_id"], name: "index_multiple_choices_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_multiple_choices_on_resource_type_and_resource_id"
  end

  create_table "not_alloweds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_cases", force: :cascade do |t|
    t.string "name"
    t.string "functionality"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_notification_cases_on_discarded_at"
    t.index ["external_id"], name: "index_notification_cases_on_external_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "notification_case_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.boolean "got_it", default: false, null: false
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["discarded_at"], name: "index_notifications_on_discarded_at"
    t.index ["external_id"], name: "index_notifications_on_external_id"
    t.index ["notification_case_id"], name: "index_notifications_on_notification_case_id"
    t.index ["resource_type", "resource_id"], name: "index_notifications_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "object_orders", force: :cascade do |t|
    t.integer "level"
    t.string "superior_type"
    t.bigint "superior_id"
    t.string "subordinate_type"
    t.bigint "subordinate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["subordinate_type", "subordinate_id"], name: "index_object_orders_on_subordinate_type_and_subordinate_id"
    t.index ["superior_type", "superior_id"], name: "index_object_orders_on_superior_type_and_superior_id"
  end

  create_table "origination_modules", force: :cascade do |t|
    t.string "name"
    t.string "option"
    t.float "order"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "origination_id"
    t.text "introduction"
    t.string "options"
    t.boolean "done", default: false
    t.index ["discarded_at"], name: "index_origination_modules_on_discarded_at"
    t.index ["external_id"], name: "index_origination_modules_on_external_id"
    t.index ["origination_id"], name: "index_origination_modules_on_origination_id"
  end

  create_table "origination_sections", force: :cascade do |t|
    t.bigint "origination_module_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.text "options"
    t.string "alternative_label"
    t.boolean "review"
    t.text "description"
    t.boolean "visible_in_review_questionnaire"
    t.index ["discarded_at"], name: "index_origination_sections_on_discarded_at"
    t.index ["external_id"], name: "index_origination_sections_on_external_id"
    t.index ["origination_module_id"], name: "index_origination_sections_on_origination_module_id"
    t.index ["resource_type", "resource_id"], name: "index_origination_sections_on_resource_type_and_resource_id"
  end

  create_table "originations", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_originations_on_discarded_at"
    t.index ["external_id"], name: "index_originations_on_external_id"
  end

  create_table "payment_agreements", force: :cascade do |t|
    t.float "value"
    t.float "rate"
    t.integer "number_payments"
    t.string "status"
    t.string "agreement_case"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.bigint "billing_document_id"
    t.float "cuota_value"
    t.bigint "isa_id"
    t.index ["billing_document_id"], name: "index_payment_agreements_on_billing_document_id"
    t.index ["discarded_at"], name: "index_payment_agreements_on_discarded_at"
    t.index ["external_id"], name: "index_payment_agreements_on_external_id"
    t.index ["isa_id"], name: "index_payment_agreements_on_isa_id"
  end

  create_table "payment_batches", force: :cascade do |t|
    t.bigint "fund_id"
    t.integer "month"
    t.integer "year"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "target_isas"
    t.boolean "send_comunication_to_student", default: true
    t.index ["discarded_at"], name: "index_payment_batches_on_discarded_at"
    t.index ["external_id"], name: "index_payment_batches_on_external_id"
    t.index ["fund_id"], name: "index_payment_batches_on_fund_id"
  end

  create_table "payment_configs", force: :cascade do |t|
    t.bigint "funding_opportunity_id"
    t.float "conciliation_rate"
    t.float "normalization_rate"
    t.float "termination_rate"
    t.float "arrears_rate"
    t.integer "payments_to_default"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "penalty_case"
    t.float "nominal_penalty"
    t.float "top_rate_cap", default: 0.0
    t.index ["discarded_at"], name: "index_payment_configs_on_discarded_at"
    t.index ["external_id"], name: "index_payment_configs_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_payment_configs_on_funding_opportunity_id"
  end

  create_table "payment_excesses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "payment_id"
    t.float "value"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_payment_excesses_on_discarded_at"
    t.index ["external_id"], name: "index_payment_excesses_on_external_id"
    t.index ["payment_id"], name: "index_payment_excesses_on_payment_id"
    t.index ["user_id"], name: "index_payment_excesses_on_user_id"
  end

  create_table "payment_mass_details", force: :cascade do |t|
    t.bigint "payment_id"
    t.bigint "payment_mass_id"
    t.bigint "billing_document_id"
    t.string "bank_number"
    t.string "ref_1"
    t.string "ref_2"
    t.float "value"
    t.date "transaction_date"
    t.string "office"
    t.string "city"
    t.text "description"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.string "status"
    t.string "problem_case"
    t.string "origin_file_key"
    t.integer "row"
    t.integer "matches_count"
    t.string "account_case"
    t.string "fund_name"
    t.bigint "fund_id"
    t.string "identification_number"
    t.integer "disbursement_id"
    t.index ["account_case"], name: "index_payment_mass_details_on_account_case"
    t.index ["bank_number"], name: "index_payment_mass_details_on_bank_number"
    t.index ["billing_document_id"], name: "index_payment_mass_details_on_billing_document_id"
    t.index ["discarded_at"], name: "index_payment_mass_details_on_discarded_at"
    t.index ["external_id"], name: "index_payment_mass_details_on_external_id"
    t.index ["fund_id"], name: "index_payment_mass_details_on_fund_id"
    t.index ["fund_name"], name: "index_payment_mass_details_on_fund_name"
    t.index ["identification_number"], name: "index_payment_mass_details_on_identification_number"
    t.index ["matches_count"], name: "index_payment_mass_details_on_matches_count"
    t.index ["origin_file_key"], name: "index_payment_mass_details_on_origin_file_key"
    t.index ["payment_id"], name: "index_payment_mass_details_on_payment_id"
    t.index ["payment_mass_id"], name: "index_payment_mass_details_on_payment_mass_id"
    t.index ["problem_case"], name: "index_payment_mass_details_on_problem_case"
    t.index ["ref_1"], name: "index_payment_mass_details_on_ref_1"
    t.index ["ref_2"], name: "index_payment_mass_details_on_ref_2"
    t.index ["row"], name: "index_payment_mass_details_on_row"
    t.index ["status"], name: "index_payment_mass_details_on_status"
    t.index ["transaction_date"], name: "index_payment_mass_details_on_transaction_date"
    t.index ["value"], name: "index_payment_mass_details_on_value"
  end

  create_table "payment_mass_docs", force: :cascade do |t|
    t.bigint "payment_mass_detail_id"
    t.bigint "billing_document_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "value"
    t.string "status"
    t.bigint "disbursement_request_id"
    t.string "fund_name"
    t.bigint "fund_id"
    t.boolean "force_manual_value"
    t.index ["billing_document_id"], name: "index_payment_mass_docs_on_billing_document_id"
    t.index ["disbursement_request_id"], name: "index_payment_mass_docs_on_disbursement_request_id"
    t.index ["discarded_at"], name: "index_payment_mass_docs_on_discarded_at"
    t.index ["external_id"], name: "index_payment_mass_docs_on_external_id"
    t.index ["fund_id"], name: "index_payment_mass_docs_on_fund_id"
    t.index ["fund_name"], name: "index_payment_mass_docs_on_fund_name"
    t.index ["payment_mass_detail_id"], name: "index_payment_mass_docs_on_payment_mass_detail_id"
    t.index ["status"], name: "index_payment_mass_docs_on_status"
    t.index ["value"], name: "index_payment_mass_docs_on_value"
  end

  create_table "payment_masses", force: :cascade do |t|
    t.string "status"
    t.text "notes"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "margin_error", default: 0
    t.index ["company_id"], name: "index_payment_masses_on_company_id"
    t.index ["discarded_at"], name: "index_payment_masses_on_discarded_at"
    t.index ["external_id"], name: "index_payment_masses_on_external_id"
    t.index ["margin_error"], name: "index_payment_masses_on_margin_error"
    t.index ["status"], name: "index_payment_masses_on_status"
  end

  create_table "payment_matches", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "value"
    t.string "target_record_type"
    t.bigint "target_record_id"
    t.index ["discarded_at"], name: "index_payment_matches_on_discarded_at"
    t.index ["external_id"], name: "index_payment_matches_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_payment_matches_on_resource_type_and_resource_id"
  end

  create_table "payment_originations", force: :cascade do |t|
    t.boolean "debit_card"
    t.boolean "cash"
    t.boolean "credit_card"
    t.boolean "bank_transfer"
    t.boolean "manual_payment"
    t.bigint "manual_payment_origination_id"
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fund_id"
    t.index ["company_id"], name: "index_payment_originations_on_company_id"
    t.index ["discarded_at"], name: "index_payment_originations_on_discarded_at"
    t.index ["external_id"], name: "index_payment_originations_on_external_id"
    t.index ["fund_id"], name: "index_payment_originations_on_fund_id"
    t.index ["manual_payment_origination_id"], name: "index_payment_originations_on_manual_payment_origination_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "billing_document_id"
    t.string "status"
    t.boolean "matching_problem_check"
    t.string "matching_problem_case"
    t.string "payment_source"
    t.string "payment_method"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.date "payment_date"
    t.string "payment_reference"
    t.bigint "disbursement_id"
    t.index ["billing_document_id"], name: "index_payments_on_billing_document_id"
    t.index ["disbursement_id"], name: "index_payments_on_disbursement_id"
    t.index ["discarded_at"], name: "index_payments_on_discarded_at"
    t.index ["external_id"], name: "index_payments_on_external_id"
    t.index ["payment_date"], name: "index_payments_on_payment_date"
    t.index ["payment_method"], name: "index_payments_on_payment_method"
    t.index ["payment_source"], name: "index_payments_on_payment_source"
    t.index ["resource_id", "value", "resource_type", "billing_document_id"], name: "uniq_payment", unique: true
    t.index ["resource_type", "resource_id"], name: "index_payments_on_resource_type_and_resource_id"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["value"], name: "index_payments_on_value"
  end

  create_table "payu_additional_infos", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payu_response_id"
    t.index ["discarded_at"], name: "index_payu_additional_infos_on_discarded_at"
    t.index ["external_id"], name: "index_payu_additional_infos_on_external_id"
    t.index ["payu_response_id"], name: "index_payu_additional_infos_on_payu_response_id"
  end

  create_table "payu_confirmations", force: :cascade do |t|
    t.float "merchant_id"
    t.string "state_pol"
    t.float "risk"
    t.string "response_code_pol"
    t.string "reference_sale"
    t.string "reference_pol"
    t.string "sign"
    t.string "extra1"
    t.string "extra2"
    t.float "payment_method"
    t.float "payment_method_type"
    t.float "installments_number"
    t.float "value"
    t.float "tax"
    t.float "additional_value"
    t.string "transaction_date"
    t.string "currency"
    t.string "email_buyer"
    t.string "cus"
    t.string "pse_bank"
    t.boolean "test"
    t.string "description"
    t.string "billing_address"
    t.string "shipping_address"
    t.string "phone"
    t.string "office_phone"
    t.string "account_number_ach"
    t.string "account_type_ach"
    t.float "administrative_fee"
    t.float "administrative_fee_base"
    t.float "administrative_fee_tax"
    t.string "airline_code"
    t.float "attempts"
    t.string "authorization_code"
    t.string "travel_agency_authorization_code"
    t.string "bank_id"
    t.string "billing_city"
    t.string "billing_country"
    t.float "commision_pol"
    t.string "commision_pol_currency"
    t.float "customer_number"
    t.string "date"
    t.string "error_code_bank"
    t.string "error_message_bank"
    t.float "exchange_rate"
    t.string "ip"
    t.string "nickname_buyer"
    t.string "nickname_seller"
    t.float "payment_method_id"
    t.string "payment_request_state"
    t.string "psereference1"
    t.string "psereference2"
    t.string "psereference3"
    t.string "response_message_pol"
    t.string "shipping_city"
    t.string "shipping_country"
    t.string "transaction_bank_id"
    t.string "transaction_id"
    t.string "payment_method_name"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_payu_confirmations_on_discarded_at"
    t.index ["external_id"], name: "index_payu_confirmations_on_external_id"
  end

  create_table "payu_extra_params", force: :cascade do |t|
    t.bigint "payu_response_id"
    t.string "key"
    t.string "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_payu_extra_params_on_discarded_at"
    t.index ["external_id"], name: "index_payu_extra_params_on_external_id"
    t.index ["payu_response_id"], name: "index_payu_extra_params_on_payu_response_id"
  end

  create_table "payu_gateways", force: :cascade do |t|
    t.bigint "company_id"
    t.string "gateway_case"
    t.string "api_key"
    t.string "api_login"
    t.string "account_id"
    t.string "merchant_id"
    t.string "url"
    t.integer "cash_hours"
    t.string "name"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "fixed_fee"
    t.float "variable_fee"
    t.index ["company_id"], name: "index_payu_gateways_on_company_id"
    t.index ["discarded_at"], name: "index_payu_gateways_on_discarded_at"
    t.index ["external_id"], name: "index_payu_gateways_on_external_id"
  end

  create_table "payu_responses", force: :cascade do |t|
    t.string "code"
    t.string "error"
    t.integer "order_id"
    t.string "transaction_id"
    t.string "state"
    t.string "response_code"
    t.string "payment_network_response_code"
    t.string "payment_network_response_error_message"
    t.string "trazability_code"
    t.string "authorization_code"
    t.string "response_message"
    t.string "operation_date"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payu_transaction_id"
    t.string "pending_reason"
    t.string "error_code"
    t.string "transaction_date"
    t.string "transaction_time"
    t.string "reference_questionnaire"
    t.datetime "last_review_datetime"
    t.index ["discarded_at"], name: "index_payu_responses_on_discarded_at"
    t.index ["external_id"], name: "index_payu_responses_on_external_id"
    t.index ["payu_transaction_id"], name: "index_payu_responses_on_payu_transaction_id"
  end

  create_table "payu_transactions", force: :cascade do |t|
    t.string "payment_method"
    t.float "value"
    t.float "tax"
    t.float "base"
    t.bigint "billing_document_id"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.bigint "payu_gateway_id"
    t.index ["billing_document_id"], name: "index_payu_transactions_on_billing_document_id"
    t.index ["discarded_at"], name: "index_payu_transactions_on_discarded_at"
    t.index ["external_id"], name: "index_payu_transactions_on_external_id"
    t.index ["payu_gateway_id"], name: "index_payu_transactions_on_payu_gateway_id"
  end

  create_table "personal_covid_emergencies", force: :cascade do |t|
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_personal_covid_emergencies_on_discarded_at"
    t.index ["external_id"], name: "index_personal_covid_emergencies_on_external_id"
    t.index ["user_id"], name: "index_personal_covid_emergencies_on_user_id"
  end

  create_table "personal_informations", force: :cascade do |t|
    t.date "birthday"
    t.string "marital_status"
    t.string "gender"
    t.string "document_type"
    t.string "identification_number"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "document_expiry_date"
    t.string "rfc"
    t.string "curp_id"
    t.string "curp_document"
    t.string "nationality"
    t.index ["discarded_at"], name: "index_personal_informations_on_discarded_at"
    t.index ["external_id"], name: "index_personal_informations_on_external_id"
    t.index ["user_id"], name: "index_personal_informations_on_user_id"
  end

  create_table "pricing_details", force: :cascade do |t|
    t.string "case"
    t.decimal "min"
    t.decimal "max"
    t.decimal "percentage"
    t.float "initial_income_cap"
    t.float "cash_reserves_needed"
    t.integer "exit_year"
    t.bigint "pricing_table_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case"], name: "index_pricing_details_on_case"
    t.index ["discarded_at"], name: "index_pricing_details_on_discarded_at"
    t.index ["external_id"], name: "index_pricing_details_on_external_id"
    t.index ["max"], name: "index_pricing_details_on_max"
    t.index ["min"], name: "index_pricing_details_on_min"
    t.index ["pricing_table_id"], name: "index_pricing_details_on_pricing_table_id"
  end

  create_table "pricing_tables", force: :cascade do |t|
    t.bigint "institutions_id"
    t.bigint "funding_opportunities_id"
    t.string "grade_level"
    t.string "cluster"
    t.integer "isa_length"
    t.float "real_cap"
    t.float "reference_value"
    t.string "periodicity"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster"], name: "index_pricing_tables_on_cluster"
    t.index ["discarded_at"], name: "index_pricing_tables_on_discarded_at"
    t.index ["external_id"], name: "index_pricing_tables_on_external_id"
    t.index ["funding_opportunities_id"], name: "index_pricing_tables_on_funding_opportunities_id"
    t.index ["grade_level"], name: "index_pricing_tables_on_grade_level"
    t.index ["institutions_id"], name: "index_pricing_tables_on_institutions_id"
  end

  create_table "pricing_vectors", force: :cascade do |t|
    t.bigint "pricing_detail_id"
    t.decimal "salary"
    t.decimal "repayment"
    t.decimal "service"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_pricing_vectors_on_discarded_at"
    t.index ["external_id"], name: "index_pricing_vectors_on_external_id"
    t.index ["pricing_detail_id"], name: "index_pricing_vectors_on_pricing_detail_id"
  end

  create_table "process_originations", force: :cascade do |t|
    t.bigint "bank_account_id"
    t.bigint "identification_document_id"
    t.bigint "funding_opportunity_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mentory_empleability_invitation_origination_id"
    t.index ["bank_account_id"], name: "index_process_originations_on_bank_account_id"
    t.index ["discarded_at"], name: "index_process_originations_on_discarded_at"
    t.index ["external_id"], name: "index_process_originations_on_external_id"
    t.index ["funding_opportunity_id"], name: "index_process_originations_on_funding_opportunity_id"
    t.index ["identification_document_id"], name: "index_process_originations_on_identification_document_id"
  end

  create_table "project_cards", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.bigint "project_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_cards_on_discarded_at"
    t.index ["external_id"], name: "index_project_cards_on_external_id"
    t.index ["project_id"], name: "index_project_cards_on_project_id"
  end

  create_table "project_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "project_task_id"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_comments_on_discarded_at"
    t.index ["external_id"], name: "index_project_comments_on_external_id"
    t.index ["project_task_id"], name: "index_project_comments_on_project_task_id"
    t.index ["user_id"], name: "index_project_comments_on_user_id"
  end

  create_table "project_favorites", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_favorites_on_discarded_at"
    t.index ["external_id"], name: "index_project_favorites_on_external_id"
    t.index ["project_id"], name: "index_project_favorites_on_project_id"
    t.index ["user_id"], name: "index_project_favorites_on_user_id"
  end

  create_table "project_task_translates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "language"
    t.bigint "project_task_type_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_task_translates_on_discarded_at"
    t.index ["external_id"], name: "index_project_task_translates_on_external_id"
    t.index ["project_task_type_id"], name: "index_project_task_translates_on_project_task_type_id"
  end

  create_table "project_task_type_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_task_type_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_task_type_users_on_discarded_at"
    t.index ["external_id"], name: "index_project_task_type_users_on_external_id"
    t.index ["project_task_type_id"], name: "index_project_task_type_users_on_project_task_type_id"
    t.index ["user_id"], name: "index_project_task_type_users_on_user_id"
  end

  create_table "project_task_types", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "functionality"
    t.boolean "free_promotion", default: true
    t.boolean "multilanguage", default: true
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_task_types_on_discarded_at"
    t.index ["external_id"], name: "index_project_task_types_on_external_id"
    t.index ["free_promotion"], name: "index_project_task_types_on_free_promotion"
    t.index ["multilanguage"], name: "index_project_task_types_on_multilanguage"
    t.index ["title"], name: "index_project_task_types_on_title"
  end

  create_table "project_tasks", force: :cascade do |t|
    t.text "title"
    t.datetime "done_date"
    t.boolean "done", default: false
    t.text "description"
    t.date "deadline"
    t.bigint "responsable_id"
    t.bigint "created_by_id"
    t.bigint "project_task_type_id"
    t.boolean "archived", default: false
    t.bigint "project_card_id"
    t.integer "position"
    t.bigint "parent_id"
    t.boolean "locked", default: false
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "progress", default: "0.0"
    t.boolean "automatic_done", default: false, null: false
    t.date "start_date"
    t.decimal "automatic_percentage"
    t.boolean "private", default: false, null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.integer "list_order"
    t.boolean "read_check"
    t.string "task_source"
    t.integer "expected_response_time"
    t.text "response"
    t.string "priority"
    t.string "task_case"
    t.float "task_score"
    t.string "requirement_type"
    t.index ["archived"], name: "index_project_tasks_on_archived"
    t.index ["company_id"], name: "index_project_tasks_on_company_id"
    t.index ["created_by_id"], name: "index_project_tasks_on_created_by_id"
    t.index ["deadline"], name: "index_project_tasks_on_deadline"
    t.index ["discarded_at"], name: "index_project_tasks_on_discarded_at"
    t.index ["done"], name: "index_project_tasks_on_done"
    t.index ["done_date"], name: "index_project_tasks_on_done_date"
    t.index ["external_id"], name: "index_project_tasks_on_external_id"
    t.index ["locked"], name: "index_project_tasks_on_locked"
    t.index ["parent_id"], name: "index_project_tasks_on_parent_id"
    t.index ["project_card_id"], name: "index_project_tasks_on_project_card_id"
    t.index ["project_task_type_id"], name: "index_project_tasks_on_project_task_type_id"
    t.index ["resource_type", "resource_id"], name: "index_project_tasks_on_resource_type_and_resource_id"
    t.index ["responsable_id"], name: "index_project_tasks_on_responsable_id"
    t.index ["title"], name: "index_project_tasks_on_title"
  end

  create_table "project_teams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_teams_on_discarded_at"
    t.index ["external_id"], name: "index_project_teams_on_external_id"
    t.index ["project_id"], name: "index_project_teams_on_project_id"
    t.index ["user_id"], name: "index_project_teams_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.boolean "private"
    t.bigint "owner_id"
    t.boolean "person_project", default: false
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archive"
    t.decimal "progress"
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["discarded_at"], name: "index_projects_on_discarded_at"
    t.index ["external_id"], name: "index_projects_on_external_id"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["person_project"], name: "index_projects_on_person_project"
    t.index ["resource_type", "resource_id"], name: "index_projects_on_resource_type_and_resource_id"
  end

  create_table "questionnaire_accumulations", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["discarded_at"], name: "index_questionnaire_accumulations_on_discarded_at"
    t.index ["external_id"], name: "index_questionnaire_accumulations_on_external_id"
    t.index ["questionnaire_id"], name: "index_questionnaire_accumulations_on_questionnaire_id"
  end

  create_table "questionnaire_exceptions", force: :cascade do |t|
    t.bigint "user_questionnaire_id"
    t.text "description"
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_questionnaire_exceptions_on_discarded_at"
    t.index ["external_id"], name: "index_questionnaire_exceptions_on_external_id"
    t.index ["user_questionnaire_id"], name: "index_questionnaire_exceptions_on_user_questionnaire_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.bigint "parent_id"
    t.float "max_score", default: 100.0
    t.integer "position"
    t.float "min_approval_score", default: 60.0
    t.integer "time_limit"
    t.float "weight", default: 100.0
    t.string "status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "instructions"
    t.string "validity"
    t.string "type_of_quesitonnaire"
    t.bigint "company_id"
    t.integer "questions_per_page"
    t.index ["category"], name: "index_questionnaires_on_category"
    t.index ["company_id"], name: "index_questionnaires_on_company_id"
    t.index ["discarded_at"], name: "index_questionnaires_on_discarded_at"
    t.index ["external_id"], name: "index_questionnaires_on_external_id"
    t.index ["parent_id"], name: "index_questionnaires_on_parent_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.integer "position"
    t.string "category"
    t.float "max_score", default: 100.0
    t.bigint "questionnaire_id"
    t.float "weight", default: 100.0
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["discarded_at"], name: "index_questions_on_discarded_at"
    t.index ["external_id"], name: "index_questions_on_external_id"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "rate_cap_updates", force: :cascade do |t|
    t.float "rate_cap_value"
    t.integer "responsible_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
  end

  create_table "references", force: :cascade do |t|
    t.string "first_name"
    t.bigint "country_id"
    t.string "middle_name"
    t.string "last_name"
    t.string "indentification_case"
    t.date "birthday"
    t.string "phone"
    t.string "mobile"
    t.string "address_1"
    t.bigint "city_id"
    t.bigint "state_id"
    t.string "relationship"
    t.string "other_relationship"
    t.string "identification_number"
    t.integer "unemployment_months"
    t.string "reference_email"
    t.string "labor_situation"
    t.string "education_level"
    t.string "guardian"
    t.string "company"
    t.string "occupation"
    t.string "work_address"
    t.string "work_phone"
    t.string "marital_status"
    t.float "total_income"
    t.boolean "jointly_liable"
    t.string "address_2"
    t.string "zip_code"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.string "validation_status"
    t.text "notes"
    t.boolean "guardian_check"
    t.string "other_phone"
    t.string "reference_case"
    t.integer "row"
    t.string "labor_contract_case"
    t.string "seniority"
    t.string "municipality"
    t.string "neighborhood"
    t.string "rfc"
    t.string "curp_id"
    t.string "curp_document"
    t.string "nationality"
    t.string "reference_economic_field"
    t.index ["city_id"], name: "index_references_on_city_id"
    t.index ["country_id"], name: "index_references_on_country_id"
    t.index ["discarded_at"], name: "index_references_on_discarded_at"
    t.index ["external_id"], name: "index_references_on_external_id"
    t.index ["state_id"], name: "index_references_on_state_id"
    t.index ["user_id"], name: "index_references_on_user_id"
  end

  create_table "requesting_modifications", force: :cascade do |t|
    t.bigint "application_id"
    t.string "status"
    t.text "changes_description"
    t.date "deadline"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_requesting_modifications_on_application_id"
    t.index ["discarded_at"], name: "index_requesting_modifications_on_discarded_at"
    t.index ["external_id"], name: "index_requesting_modifications_on_external_id"
  end

  create_table "research_filters", force: :cascade do |t|
    t.bigint "variable_id"
    t.bigint "filter_id"
    t.integer "order"
    t.string "acronym"
    t.integer "level"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_research_filters_on_country_id"
    t.index ["discarded_at"], name: "index_research_filters_on_discarded_at"
    t.index ["external_id"], name: "index_research_filters_on_external_id"
    t.index ["filter_id"], name: "index_research_filters_on_filter_id"
    t.index ["variable_id"], name: "index_research_filters_on_variable_id"
  end

  create_table "research_inputs", force: :cascade do |t|
    t.string "params_name"
    t.string "format"
    t.text "description"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "research_process_id"
    t.index ["discarded_at"], name: "index_research_inputs_on_discarded_at"
    t.index ["external_id"], name: "index_research_inputs_on_external_id"
    t.index ["research_process_id"], name: "index_research_inputs_on_research_process_id"
  end

  create_table "research_model_infos", force: :cascade do |t|
    t.bigint "research_variable_id"
    t.float "value"
    t.string "info_format"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_text"
    t.boolean "active", default: true
    t.index ["discarded_at"], name: "index_research_model_infos_on_discarded_at"
    t.index ["external_id"], name: "index_research_model_infos_on_external_id"
    t.index ["research_variable_id"], name: "index_research_model_infos_on_research_variable_id"
  end

  create_table "research_processes", force: :cascade do |t|
    t.string "process"
    t.string "url"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verb"
    t.string "action"
    t.index ["discarded_at"], name: "index_research_processes_on_discarded_at"
    t.index ["external_id"], name: "index_research_processes_on_external_id"
  end

  create_table "research_variables", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.bigint "parent_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_of_variable"
    t.index ["discarded_at"], name: "index_research_variables_on_discarded_at"
    t.index ["external_id"], name: "index_research_variables_on_external_id"
    t.index ["parent_id"], name: "index_research_variables_on_parent_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "school_grades", force: :cascade do |t|
    t.string "year"
    t.string "mathematics"
    t.string "phisics"
    t.string "chemistry"
    t.string "social_studies"
    t.string "biology"
    t.string "language"
    t.string "behavior"
    t.bigint "student_academic_information_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "philosophy"
    t.string "academic_term"
    t.index ["discarded_at"], name: "index_school_grades_on_discarded_at"
    t.index ["external_id"], name: "index_school_grades_on_external_id"
    t.index ["student_academic_information_id"], name: "index_school_grades_on_student_academic_information_id"
  end

  create_table "school_infos", force: :cascade do |t|
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_academic_information_id"
    t.boolean "school_year_failed_check"
    t.string "school_year_failed_text"
    t.string "average_score"
    t.boolean "problem_at_school_check"
    t.string "problem_at_school_text"
    t.boolean "planning_to_take_preuniversity_classes"
    t.string "lidership"
    t.index ["discarded_at"], name: "index_school_infos_on_discarded_at"
    t.index ["external_id"], name: "index_school_infos_on_external_id"
    t.index ["student_academic_information_id"], name: "index_school_infos_on_student_academic_information_id"
  end

  create_table "searchers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_searchers_on_discarded_at"
    t.index ["external_id"], name: "index_searchers_on_external_id"
    t.index ["user_id"], name: "index_searchers_on_user_id"
  end

  create_table "sg_cobranza_202108", id: false, force: :cascade do |t|
    t.bigint "billing_id"
    t.bigint "detail_id"
    t.bigint "user_id"
    t.text "fondo"
    t.text "identification_number"
    t.text "Nombre"
    t.text "corte"
    t.text "convocatoria"
    t.text "estado"
    t.text "naturaleza"
    t.text "status"
    t.integer "year"
    t.integer "month"
    t.float "payment_equivalency"
    t.float "value"
    t.bigint "isa_id"
    t.text "detail_case"
    t.date "reference_date"
    t.text "currency"
    t.bigint "payment_agreement_id"
    t.float "applied_value"
    t.float "equivalency_covered"
    t.bigint "contador"
  end

  create_table "sg_cobranza_202109", id: false, force: :cascade do |t|
    t.bigint "billing_id"
    t.bigint "detail_id"
    t.bigint "user_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "identification_number"
    t.text "Nombre"
    t.text "corte"
    t.text "convocatoria"
    t.text "estado"
    t.text "naturaleza"
    t.text "status"
    t.integer "year"
    t.integer "month"
    t.float "payment_equivalency"
    t.float "value"
    t.bigint "isa_id"
    t.date "reference_date"
    t.text "currency"
    t.bigint "payment_agreement_id"
    t.float "applied_value"
    t.float "equivalency_covered"
    t.bigint "contador"
  end

  create_table "sg_cobranza_agrup", id: false, force: :cascade do |t|
    t.text "corte"
    t.text "tipo_de_fondo"
    t.text "fondo"
    t.text "convocatoria"
    t.text "estado"
    t.text "naturaleza"
    t.text "status"
    t.integer "year"
    t.integer "month"
    t.date "reference_date"
    t.text "currency"
    t.float "payment_equivalency"
    t.float "value"
    t.float "applied_value"
    t.float "equivalency_covered"
    t.decimal "contador"
  end

  create_table "sg_cobranza_union", id: false, force: :cascade do |t|
    t.bigint "billing_id"
    t.bigint "detail_id"
    t.bigint "user_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "identification_number"
    t.text "Nombre"
    t.text "corte"
    t.text "convocatoria"
    t.text "estado"
    t.text "naturaleza"
    t.text "status"
    t.integer "year"
    t.integer "month"
    t.float "payment_equivalency"
    t.float "value"
    t.bigint "isa_id"
    t.date "reference_date"
    t.text "currency"
    t.bigint "payment_agreement_id"
    t.float "applied_value"
    t.float "equivalency_covered"
    t.bigint "contador"
  end

  create_table "sg_currency", id: false, force: :cascade do |t|
    t.text "fecha"
    t.decimal "ultimo"
    t.text "currency"
  end

  create_table "sg_info_general", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.text "doc_iden"
    t.text "nombre"
    t.text "apellido"
    t.text "fondo_unificado"
    t.text "tipo_de_fondo"
    t.text "nivel_de_formación"
    t.text "Área_de_Conocimiento"
    t.text "núcleo_de_conocimiento"
    t.text "programa_académico"
    t.text "institución"
    t.text "país"
    t.text "ciudad_de_origen"
    t.text "departamento_de_nacimiento"
    t.text "región_de_origen"
    t.text "genero"
    t.date "fecha_de_nacimiento"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "Departamento de residencia"
    t.text "Celular"
    t.text "Teléfono"
    t.text "Teléfono 2"
    t.text "Correo electrónico"
    t.text "Dirección 1"
    t.integer "Edad"
    t.text "Estrato"
    t.text "Convocatoria"
    t.text "fecha"
    t.text "company"
    t.integer "meses_comprometidos"
    t.date "fecha_aceptación_isa"
    t.float "cuotas_repago_pagadas"
    t.float "cuotas_pendientes"
    t.float "valor_a_techo"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.bigint "row"
  end

  create_table "sg_pagos", id: false, force: :cascade do |t|
    t.text "fondo"
    t.text "convocatoria"
    t.text "fecha"
    t.text "llave"
    t.text "estado"
    t.text "currency"
    t.text "naturaleza"
    t.float "valor"
    t.decimal "tasa_de_cambo"
    t.decimal "valor_usd"
    t.decimal "n"
  end

  create_table "sg_reporte_empleabilidad", id: false, force: :cascade do |t|
    t.bigint "ID"
    t.bigint "isa id"
    t.text "Cédula"
    t.text "Nombre"
    t.text "Apellido"
    t.bigint "Fondo_id"
    t.text "Fondo"
    t.text "Tipo de fondo"
    t.text "Convocatoria"
    t.date "Fecha de graduación esperada"
    t.date "Fecha Graduación real"
    t.integer "Edad"
    t.text "Estado laboral actual"
    t.text "Estado de pagos"
    t.text "Estado académico actual"
    t.text "Estado_General"
    t.text "Empresa"
    t.float "salario"
    t.text "currency"
    t.datetime "fecha de actualización"
    t.date "Fecha inicio"
    t.text "Correo electrónico"
    t.text "Celular"
    t.text "Celular familiar"
    t.text "Referencia 1"
    t.text "Referencia 2"
    t.text "Responsable Solidario"
    t.text "País de Residencia"
    t.text "Ciudad de residencia"
    t.text "Departamento de residencia"
    t.text "Programa académico"
    t.text "Área de conocimiento"
    t.text "Núcleo de conocimiento"
  end

  create_table "sg_salarios_programa", id: false, force: :cascade do |t|
    t.bigint "id_int"
    t.bigint "id_prog"
    t.string "institution"
    t.string "programa"
    t.decimal "salario"
    t.decimal "año1"
    t.decimal "año2"
    t.decimal "año3"
    t.decimal "año4"
    t.decimal "año5"
  end

  create_table "sg_salarios_rep", id: false, force: :cascade do |t|
    t.bigint "id_llave"
    t.text "identification_number"
    t.text "institution"
    t.text "programa"
    t.text "fondo"
    t.float "cuotas_pagadas"
    t.text "estado_académico_actual"
    t.text "estado_laboral_actual"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.decimal "salario"
    t.text "currency"
    t.text "operations_status"
    t.float "salario_esperado"
  end

  create_table "sg_status", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "país"
    t.text "genero"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "departamento_de_residencia"
    t.bigint "contador"
    t.integer "nuevos_mes"
    t.text "rango_edad"
    t.integer "nuevos_ano"
  end

  create_table "sg_status_202012", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "país"
    t.text "genero"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "departamento_de_residencia"
    t.bigint "contador"
    t.integer "nuevos_mes"
    t.text "rango_edad"
    t.integer "nuevos_ano"
  end

  create_table "sg_status_202108", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "país"
    t.text "genero"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "departamento_de_residencia"
    t.bigint "contador"
    t.integer "nuevos_mes"
    t.text "rango_edad"
    t.integer "nuevos_ano"
  end

  create_table "sg_status_202109", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "país"
    t.text "genero"
    t.integer "edad"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "Departamento de residencia"
    t.bigint "contador"
    t.text "rango_edad"
    t.text "var_aux"
  end

  create_table "sg_status_202110", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "pais"
    t.text "genero"
    t.integer "edad"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "Departamento de residencia"
    t.bigint "contador"
    t.text "rango_edad"
    t.text "var_aux"
  end

  create_table "sg_status_mes", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "isa_id"
    t.bigint "fondo_id"
    t.text "fondo"
    t.text "tipo_de_fondo"
    t.text "convocatoria"
    t.text "estado_académico"
    t.text "estado_laboral"
    t.text "estado_de_pagos"
    t.text "estado_general"
    t.text "fecha"
    t.text "pais"
    t.text "genero"
    t.integer "edad"
    t.text "país_de_residencia"
    t.text "ciudad_de_residencia"
    t.text "Departamento de residencia"
    t.bigint "contador"
    t.text "rango_edad"
    t.text "var_aux"
  end

  create_table "signio_records", force: :cascade do |t|
    t.integer "legal_match_id"
    t.bigint "user_id"
    t.string "id_transaction"
    t.string "id_contract_document"
    t.string "id_promissory_document"
    t.string "id_student_in_signio"
    t.string "id_jointly_liable_in_signio"
    t.string "id_legal_representative_in_signio"
    t.string "id_zigma_representative_in_signio"
    t.jsonb "tag_coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "add_signature_coordinates_student_response"
    t.string "add_signature_coordinates_legal_representative_response"
    t.string "add_signature_coordinates_jointly_liable_response"
    t.string "add_signature_coordinates_zigma_representative_response"
    t.string "send_to_sign_response"
    t.string "comments"
    t.boolean "promissory_document_protected", default: false
    t.boolean "contract_document_protected", default: false
    t.integer "promissory_note_legal_match_id"
    t.index ["user_id"], name: "index_signio_records_on_user_id"
  end

  create_table "social_works", force: :cascade do |t|
    t.string "number_of_hours"
    t.bigint "user_id"
    t.bigint "country_id"
    t.bigint "state_id"
    t.bigint "city_id"
    t.string "term"
    t.string "institution_name"
    t.text "activities"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_id"
    t.index ["application_id"], name: "index_social_works_on_application_id"
    t.index ["city_id"], name: "index_social_works_on_city_id"
    t.index ["country_id"], name: "index_social_works_on_country_id"
    t.index ["discarded_at"], name: "index_social_works_on_discarded_at"
    t.index ["external_id"], name: "index_social_works_on_external_id"
    t.index ["state_id"], name: "index_social_works_on_state_id"
    t.index ["user_id"], name: "index_social_works_on_user_id"
  end

  create_table "sociodemographics", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "state_id"
    t.bigint "city_id"
    t.bigint "country_id"
    t.string "house_type"
    t.string "ethnicity"
    t.string "neighborhood"
    t.string "strata"
    t.string "indigenous_community"
    t.string "children_number"
    t.string "siblings_number"
    t.string "siblings_position"
    t.string "people_living_together"
    t.string "other_people_living_together"
    t.string "main_financial_support_person"
    t.string "dependent_number"
    t.string "family_living_together"
    t.string "other_family_living_together"
    t.boolean "mother_alive"
    t.boolean "father_alive"
    t.boolean "living_with_parents"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "social_program_check"
    t.string "social_program_text"
    t.string "social_program_other"
    t.string "confict_involvement"
    t.string "origin_region"
    t.string "birthplace_type"
    t.string "living_place_type"
    t.string "head_of_the_family"
    t.string "family_provider"
    t.string "first_generation_higher_education"
    t.text "hobbies_or_voluntary_description"
    t.text "community_development_description"
    t.text "leadership_description"
    t.string "gen_fifty_how_know_about_benefit"
    t.index ["city_id"], name: "index_sociodemographics_on_city_id"
    t.index ["country_id"], name: "index_sociodemographics_on_country_id"
    t.index ["discarded_at"], name: "index_sociodemographics_on_discarded_at"
    t.index ["external_id"], name: "index_sociodemographics_on_external_id"
    t.index ["state_id"], name: "index_sociodemographics_on_state_id"
    t.index ["user_id"], name: "index_sociodemographics_on_user_id"
  end

  create_table "student_academic_informations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "institution_id"
    t.bigint "major_id"
    t.boolean "other_institution_check"
    t.string "other_institution_text"
    t.boolean "other_program_check"
    t.string "other_program_text"
    t.string "score_scale"
    t.string "type_of_academic_term"
    t.integer "program_number_of_terms"
    t.string "current_academic_status"
    t.integer "current_term"
    t.date "program_start_date"
    t.date "expected_graduation_date"
    t.date "graduation_date"
    t.date "expected_egress_date"
    t.date "egress_date"
    t.date "expected_diploma_delivery_date"
    t.date "diploma_delivery_date"
    t.string "degree_obtained"
    t.string "last_period_score"
    t.boolean "ackn_scholarship_check"
    t.boolean "ackn_scholarship_text"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_value_grade"
    t.integer "max_value_grade"
    t.float "gpa"
    t.bigint "city_id"
    t.bigint "state_id"
    t.bigint "country_id"
    t.string "institution_nature"
    t.boolean "standardized_state_test_check"
    t.string "standardized_state_test_result"
    t.date "standardized_state_test_date"
    t.string "program_level"
    t.string "standardized_state_test_ranking"
    t.string "information_case"
    t.boolean "funding_need"
    t.boolean "finished_major_check"
    t.boolean "on_hold_check"
    t.integer "number_of_disbursements_requiered"
    t.integer "disbursements_periodicity"
    t.date "first_disbursement_date"
    t.float "disbursement_value"
    t.bigint "application_id"
    t.boolean "living_expenses_check"
    t.float "tuition_funded_percentage"
    t.float "tuition_value"
    t.float "living_expenses_value"
    t.boolean "drop_out"
    t.date "drop_out_date"
    t.string "stored_academic_information"
    t.string "already_admitted"
    t.boolean "change_city_to_study", default: false
    t.string "study_modality"
    t.string "last_academic_level_fulfilled"
    t.date "graduation_date_last_academic_level_fulfilled"
    t.index ["application_id"], name: "index_student_academic_informations_on_application_id"
    t.index ["city_id"], name: "index_student_academic_informations_on_city_id"
    t.index ["country_id"], name: "index_student_academic_informations_on_country_id"
    t.index ["discarded_at"], name: "index_student_academic_informations_on_discarded_at"
    t.index ["external_id"], name: "index_student_academic_informations_on_external_id"
    t.index ["institution_id"], name: "index_student_academic_informations_on_institution_id"
    t.index ["major_id"], name: "index_student_academic_informations_on_major_id"
    t.index ["state_id"], name: "index_student_academic_informations_on_state_id"
    t.index ["user_id"], name: "index_student_academic_informations_on_user_id"
  end

  create_table "student_answers", force: :cascade do |t|
    t.bigint "student_score_id"
    t.bigint "answers_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answers_id"], name: "index_student_answers_on_answers_id"
    t.index ["discarded_at"], name: "index_student_answers_on_discarded_at"
    t.index ["external_id"], name: "index_student_answers_on_external_id"
    t.index ["student_score_id"], name: "index_student_answers_on_student_score_id"
  end

  create_table "student_configs", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "applies_workshops"
    t.boolean "applies_mentoring"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_student_configs_on_discarded_at"
    t.index ["external_id"], name: "index_student_configs_on_external_id"
    t.index ["user_id"], name: "index_student_configs_on_user_id"
  end

  create_table "student_debts", force: :cascade do |t|
    t.string "type_of_debt"
    t.date "start_payment_date"
    t.date "end_payment_date"
    t.float "amount"
    t.float "yearly_interest_rate"
    t.string "what_did_you_ask_the_money_for"
    t.string "payment_periodicity"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entity"
    t.float "monthly_payment"
    t.bigint "user_id"
    t.index ["discarded_at"], name: "index_student_debts_on_discarded_at"
    t.index ["external_id"], name: "index_student_debts_on_external_id"
    t.index ["user_id"], name: "index_student_debts_on_user_id"
  end

  create_table "student_email_batches", force: :cascade do |t|
    t.string "email_case"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_expenses", force: :cascade do |t|
    t.string "type_of_expenses"
    t.float "value"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_financial_information_id"
    t.index ["discarded_at"], name: "index_student_expenses_on_discarded_at"
    t.index ["external_id"], name: "index_student_expenses_on_external_id"
    t.index ["student_financial_information_id"], name: "index_student_expenses_on_student_financial_information_id"
  end

  create_table "student_financial_informations", force: :cascade do |t|
    t.float "total_personal_income"
    t.string "who_pays_your_expenses"
    t.string "what_is_your_income_source"
    t.string "do_you_use_banking_service", default: "false"
    t.string "do_you_have_these_goods"
    t.boolean "does_the_family_prioritize_activities", default: false
    t.string "family_support_frequency"
    t.float "expenses_academic_activities"
    t.string "other_financial_sources"
    t.boolean "will_you_work_while_studying", default: false
    t.boolean "can_you_access_school_resources", default: false
    t.float "salary_after_5_years_of_graduation"
    t.boolean "do_you_have_savings", default: false
    t.float "savings_value"
    t.boolean "do_you_have_family_economical_support", default: false
    t.float "family_support_value"
    t.float "debt_value"
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "entertainment_expenses"
    t.float "home_expenses"
    t.float "dependent_expenses"
    t.float "personal_goods_expenses"
    t.float "transportation_expenses"
    t.float "food_expenses"
    t.float "other_people_value"
    t.float "personal_business_value"
    t.float "federal_aid_value"
    t.float "temporal_work_value"
    t.float "full_time_employ_value"
    t.float "partial_time_employ_value"
    t.string "other_people_frequency"
    t.string "personal_business_frequency"
    t.string "federal_aid_frequency"
    t.string "temporal_work_frequency"
    t.string "full_time_employ_frequency"
    t.string "partial_time_employ_frequency"
    t.float "total_expenses"
    t.boolean "billing_to_someone_else", default: false
    t.string "billing_owner_rfc"
    t.string "billing_owner_first_name"
    t.string "billing_owner_middle_name"
    t.string "billing_owner_last_name"
    t.string "billing_owner_bussiness_name"
    t.string "billing_owner_email"
    t.string "billing_owner_address"
    t.index ["discarded_at"], name: "index_student_financial_informations_on_discarded_at"
    t.index ["external_id"], name: "index_student_financial_informations_on_external_id"
    t.index ["user_id"], name: "index_student_financial_informations_on_user_id"
  end

  create_table "student_reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.date "report_date"
    t.text "comments"
    t.bigint "created_by_id"
    t.string "state"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_student_reviews_on_created_by_id"
    t.index ["discarded_at"], name: "index_student_reviews_on_discarded_at"
    t.index ["external_id"], name: "index_student_reviews_on_external_id"
    t.index ["user_id"], name: "index_student_reviews_on_user_id"
  end

  create_table "student_routes", force: :cascade do |t|
    t.bigint "team_profile_id"
    t.string "scenario"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["discarded_at"], name: "index_student_routes_on_discarded_at"
    t.index ["external_id"], name: "index_student_routes_on_external_id"
    t.index ["resource_type", "resource_id"], name: "index_student_routes_on_resource_type_and_resource_id"
    t.index ["team_profile_id"], name: "index_student_routes_on_team_profile_id"
  end

  create_table "student_scores", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.float "score"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_student_scores_on_discarded_at"
    t.index ["external_id"], name: "index_student_scores_on_external_id"
    t.index ["questionnaire_id"], name: "index_student_scores_on_questionnaire_id"
  end

  create_table "student_token_batches", force: :cascade do |t|
    t.string "status", default: "active"
    t.bigint "funding_opportunity_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funding_opportunity_id"], name: "index_student_token_batches_on_funding_opportunity_id"
  end

  create_table "support_roles", force: :cascade do |t|
    t.string "role_case"
    t.text "role_description"
    t.string "role_status"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "response_in_days"
    t.integer "response_in_hours"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_support_roles_on_company_id"
    t.index ["discarded_at"], name: "index_support_roles_on_discarded_at"
    t.index ["external_id"], name: "index_support_roles_on_external_id"
  end

  create_table "team_approvals", force: :cascade do |t|
    t.bigint "team_profile_id"
    t.bigint "role_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_team_approvals_on_discarded_at"
    t.index ["external_id"], name: "index_team_approvals_on_external_id"
    t.index ["role_id"], name: "index_team_approvals_on_role_id"
    t.index ["team_profile_id"], name: "index_team_approvals_on_team_profile_id"
  end

  create_table "team_profile_templates", force: :cascade do |t|
    t.bigint "form_template_id"
    t.bigint "team_profile_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "controller_name"
    t.index ["discarded_at"], name: "index_team_profile_templates_on_discarded_at"
    t.index ["external_id"], name: "index_team_profile_templates_on_external_id"
    t.index ["form_template_id"], name: "index_team_profile_templates_on_form_template_id"
    t.index ["team_profile_id"], name: "index_team_profile_templates_on_team_profile_id"
  end

  create_table "team_profiles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.bigint "form_template_id"
    t.string "action", default: "custom", null: false
    t.index ["discarded_at"], name: "index_team_profiles_on_discarded_at"
    t.index ["external_id"], name: "index_team_profiles_on_external_id"
    t.index ["form_template_id"], name: "index_team_profiles_on_form_template_id"
  end

  create_table "team_profiles_roles", id: false, force: :cascade do |t|
    t.bigint "team_profile_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_team_profiles_roles_on_role_id"
    t.index ["team_profile_id", "role_id"], name: "index_team_profiles_roles_on_team_profile_id_and_role_id"
    t.index ["team_profile_id"], name: "index_team_profiles_roles_on_team_profile_id"
  end

  create_table "team_supervisor_batches", force: :cascade do |t|
    t.string "description"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_team_supervisor_batches_on_discarded_at"
  end

  create_table "team_supervisors", force: :cascade do |t|
    t.bigint "supervisor_id"
    t.bigint "team_member_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "support_role_id"
    t.index ["discarded_at"], name: "index_team_supervisors_on_discarded_at"
    t.index ["external_id"], name: "index_team_supervisors_on_external_id"
    t.index ["supervisor_id"], name: "index_team_supervisors_on_supervisor_id"
    t.index ["support_role_id"], name: "index_team_supervisors_on_support_role_id"
    t.index ["team_member_id"], name: "index_team_supervisors_on_team_member_id"
  end

  create_table "university_course_grades", force: :cascade do |t|
    t.string "name"
    t.float "final_score"
    t.integer "credits"
    t.string "status"
    t.bigint "university_grade_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_number"
    t.string "partial_score"
    t.boolean "done", default: false
    t.index ["discarded_at"], name: "index_university_course_grades_on_discarded_at"
    t.index ["external_id"], name: "index_university_course_grades_on_external_id"
    t.index ["university_grade_id"], name: "index_university_course_grades_on_university_grade_id"
  end

  create_table "university_grades", force: :cascade do |t|
    t.bigint "student_academic_information_id"
    t.string "grade"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_courses_taken"
    t.integer "number_of_courses_failed"
    t.integer "number_of_credits"
    t.integer "term"
    t.string "period"
    t.text "comments"
    t.boolean "confirmed", default: false
    t.bigint "disbursement_id"
    t.bigint "application_id"
    t.bigint "academic_bonus_id"
    t.index ["academic_bonus_id"], name: "index_university_grades_on_academic_bonus_id"
    t.index ["application_id"], name: "index_university_grades_on_application_id"
    t.index ["disbursement_id"], name: "index_university_grades_on_disbursement_id"
    t.index ["discarded_at"], name: "index_university_grades_on_discarded_at"
    t.index ["external_id"], name: "index_university_grades_on_external_id"
    t.index ["student_academic_information_id"], name: "index_university_grades_on_student_academic_information_id"
  end

  create_table "university_infos", force: :cascade do |t|
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_academic_information_id"
    t.string "shift"
    t.integer "number_subjects_taken"
    t.integer "number_subjects_failed"
    t.boolean "problems_with_subjects_check"
    t.string "problems_with_subjects_text"
    t.boolean "accepted_in_university"
    t.boolean "reprimands_for_low_assistance"
    t.index ["discarded_at"], name: "index_university_infos_on_discarded_at"
    t.index ["external_id"], name: "index_university_infos_on_external_id"
    t.index ["student_academic_information_id"], name: "index_university_infos_on_student_academic_information_id"
  end

  create_table "user_aggregations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_user_aggregations_on_discarded_at"
    t.index ["external_id"], name: "index_user_aggregations_on_external_id"
    t.index ["user_id"], name: "index_user_aggregations_on_user_id"
  end

  create_table "user_questionnaire_answers", force: :cascade do |t|
    t.bigint "answer_id"
    t.bigint "user_questionnaire_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["answer_id"], name: "index_user_questionnaire_answers_on_answer_id"
    t.index ["discarded_at"], name: "index_user_questionnaire_answers_on_discarded_at"
    t.index ["external_id"], name: "index_user_questionnaire_answers_on_external_id"
    t.index ["user_questionnaire_id"], name: "index_user_questionnaire_answers_on_user_questionnaire_id"
  end

  create_table "user_questionnaire_follow_ups", force: :cascade do |t|
    t.bigint "user_questionnaire_id"
    t.string "state"
    t.datetime "resolved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.index ["user_questionnaire_id"], name: "index_user_questionnaire_follow_ups_on_user_questionnaire_id"
  end

  create_table "user_questionnaire_scores", force: :cascade do |t|
    t.bigint "user_questionnaire_id"
    t.bigint "questionnaire_id"
    t.float "score"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_user_questionnaire_scores_on_discarded_at"
    t.index ["external_id"], name: "index_user_questionnaire_scores_on_external_id"
    t.index ["questionnaire_id"], name: "index_user_questionnaire_scores_on_questionnaire_id"
    t.index ["user_questionnaire_id"], name: "index_user_questionnaire_scores_on_user_questionnaire_id"
  end

  create_table "user_questionnaires", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "questionnaire_id"
    t.string "status", default: "pending", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "result"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expiration_date"
    t.string "resource_type"
    t.bigint "resource_id"
    t.bigint "application_id"
    t.boolean "confirmed"
    t.index ["application_id"], name: "index_user_questionnaires_on_application_id"
    t.index ["discarded_at"], name: "index_user_questionnaires_on_discarded_at"
    t.index ["end_time"], name: "index_user_questionnaires_on_end_time"
    t.index ["external_id"], name: "index_user_questionnaires_on_external_id"
    t.index ["questionnaire_id"], name: "index_user_questionnaires_on_questionnaire_id"
    t.index ["resource_type", "resource_id"], name: "index_user_questionnaires_on_resource_type_and_resource_id"
    t.index ["result"], name: "index_user_questionnaires_on_result"
    t.index ["start_time"], name: "index_user_questionnaires_on_start_time"
    t.index ["status"], name: "index_user_questionnaires_on_status"
    t.index ["user_id"], name: "index_user_questionnaires_on_user_id"
  end

  create_table "user_scores", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "score"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.string "status", default: "active", null: false
    t.string "language", default: "en", null: false
    t.string "time_zone", default: "Bogota", null: false
    t.bigint "company_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_profile_id"
    t.string "type_of_account"
    t.string "session_token"
    t.boolean "activation_check"
    t.string "identification_number"
    t.string "searcher_name"
    t.string "income_percentile", default: "p50"
    t.boolean "for_testing", default: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["external_id"], name: "index_users_on_external_id"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["identification_number"], name: "index_users_on_identification_number"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["migrated"], name: "index_users_on_migrated"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["searcher_name"], name: "index_users_on_searcher_name"
    t.index ["status"], name: "index_users_on_status"
    t.index ["team_profile_id"], name: "index_users_on_team_profile_id"
    t.index ["type_of_account"], name: "index_users_on_type_of_account"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "valuation_details", force: :cascade do |t|
    t.date "date"
    t.float "student_flow"
    t.float "fund_flow"
    t.float "investor_flow"
    t.float "fees"
    t.bigint "valuation_history_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_valuation_details_on_discarded_at"
    t.index ["external_id"], name: "index_valuation_details_on_external_id"
    t.index ["valuation_history_id"], name: "index_valuation_details_on_valuation_history_id"
  end

  create_table "valuation_histories", force: :cascade do |t|
    t.datetime "date"
    t.bigint "user_id"
    t.integer "expected_records"
    t.string "status"
    t.bigint "fund_id"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_valuation_histories_on_discarded_at"
    t.index ["external_id"], name: "index_valuation_histories_on_external_id"
    t.index ["fund_id"], name: "index_valuation_histories_on_fund_id"
    t.index ["user_id"], name: "index_valuation_histories_on_user_id"
  end

  create_table "wompi_gateways", force: :cascade do |t|
    t.bigint "company_id"
    t.string "gateway_case", default: ""
    t.string "public_key", default: ""
    t.string "private_key", default: ""
    t.string "name", default: ""
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_code", default: ""
    t.index ["company_id"], name: "index_wompi_gateways_on_company_id"
    t.index ["discarded_at"], name: "index_wompi_gateways_on_discarded_at"
    t.index ["external_id"], name: "index_wompi_gateways_on_external_id"
  end

  create_table "wompi_responses", force: :cascade do |t|
    t.string "merchant_order_id"
    t.string "status"
    t.string "collection_id"
    t.string "payment_id"
    t.string "external_id"
    t.string "payment_type"
    t.string "preference_id"
    t.string "site_id"
    t.string "processing_mode"
    t.string "merchant_account_id"
    t.bigint "wompi_transaction_id"
    t.string "authorization_code"
    t.string "currency_id"
    t.string "date_approved"
    t.string "payment_method"
    t.string "transaction_amount"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status_detail", default: ""
    t.index ["discarded_at"], name: "index_wompi_responses_on_discarded_at"
    t.index ["external_id"], name: "index_wompi_responses_on_external_id"
    t.index ["wompi_transaction_id"], name: "index_wompi_responses_on_wompi_transaction_id"
  end

  create_table "wompi_transactions", force: :cascade do |t|
    t.string "payment_method"
    t.float "value"
    t.float "tax"
    t.float "base"
    t.bigint "billing_document_id"
    t.string "status"
    t.string "ip_address"
    t.string "external_id"
    t.datetime "discarded_at"
    t.boolean "migrated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wompi_gateway_id"
    t.string "wompi_transaction_id", default: ""
    t.index ["billing_document_id"], name: "index_wompi_transactions_on_billing_document_id"
    t.index ["discarded_at"], name: "index_wompi_transactions_on_discarded_at"
    t.index ["external_id"], name: "index_wompi_transactions_on_external_id"
    t.index ["wompi_gateway_id"], name: "index_wompi_transactions_on_wompi_gateway_id"
  end

  add_foreign_key "academi_originations", "funding_opportunities"
  add_foreign_key "academic_requests", "student_academic_informations"
  add_foreign_key "academic_stops", "student_academic_informations"
  add_foreign_key "activities_details", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "api_histories", "users"
  add_foreign_key "application_committees", "applications"
  add_foreign_key "application_committees", "invest_committees"
  add_foreign_key "application_components", "funding_opportunities"
  add_foreign_key "application_follow_ups", "applications"
  add_foreign_key "application_module_tracks", "applications"
  add_foreign_key "application_module_tracks", "origination_modules"
  add_foreign_key "application_section_tracks", "applications"
  add_foreign_key "application_section_tracks", "origination_sections"
  add_foreign_key "applications", "funding_opportunities"
  add_foreign_key "applications", "users"
  add_foreign_key "approval_matches", "users"
  add_foreign_key "backup_fields", "backup_objects"
  add_foreign_key "backup_infos", "backup_fields"
  add_foreign_key "backup_picklists", "backup_fields"
  add_foreign_key "batch_details", "isas"
  add_foreign_key "batch_details", "payment_batches"
  add_foreign_key "bff_questions", "users"
  add_foreign_key "billing_document_details", "billing_document_details"
  add_foreign_key "billing_document_details", "isas"
  add_foreign_key "billing_document_details", "payment_agreements"
  add_foreign_key "billing_document_matches", "billing_document_details"
  add_foreign_key "billing_documents", "isas"
  add_foreign_key "billing_documents", "payment_batches"
  add_foreign_key "bizdev_businesses", "bizdev_businesses"
  add_foreign_key "bizdev_operations", "bizdev_businesses"
  add_foreign_key "black_rock_data", "users"
  add_foreign_key "cancellation_configs", "funds"
  add_foreign_key "cancellation_requests", "applications"
  add_foreign_key "cancellation_requests", "disbursements"
  add_foreign_key "cancellation_requests", "isas"
  add_foreign_key "check_fields", "check_objects"
  add_foreign_key "check_modes", "check_fields"
  add_foreign_key "children", "users"
  add_foreign_key "clusters", "majors"
  add_foreign_key "collections", "users"
  add_foreign_key "communication_cases", "companies"
  add_foreign_key "communication_footers", "companies"
  add_foreign_key "communication_headers", "companies"
  add_foreign_key "communication_templates", "communication_cases"
  add_foreign_key "communication_templates", "communication_footers"
  add_foreign_key "communication_templates", "communication_headers"
  add_foreign_key "communication_templates", "companies"
  add_foreign_key "communication_users", "users"
  add_foreign_key "companies", "companies"
  add_foreign_key "companies", "countries"
  add_foreign_key "companies", "users"
  add_foreign_key "complementary_originations", "funding_opportunities"
  add_foreign_key "conciliation_informations", "income_informations"
  add_foreign_key "conciliation_informations", "isas"
  add_foreign_key "conciliation_informations", "payment_agreements"
  add_foreign_key "condonations", "disbursements"
  add_foreign_key "contracts", "applications"
  add_foreign_key "contracts", "users"
  add_foreign_key "covid_configs", "funds"
  add_foreign_key "covid_emergencies", "billing_documents"
  add_foreign_key "credit_history_checks", "users"
  add_foreign_key "custom_disbursements", "funding_tokens"
  add_foreign_key "custom_disbursements", "modelings"
  add_foreign_key "default_matrices", "countries"
  add_foreign_key "disbursement_cancellations", "cancellation_configs"
  add_foreign_key "disbursement_cancellations", "disbursements"
  add_foreign_key "disbursement_matches", "disbursement_requests"
  add_foreign_key "disbursement_matches", "disbursements"
  add_foreign_key "disbursement_originations", "companies"
  add_foreign_key "disbursement_originations", "funding_opportunities"
  add_foreign_key "disbursement_originations", "originations"
  add_foreign_key "disbursement_payments", "bank_accounts"
  add_foreign_key "disbursement_payments", "disbursement_requests"
  add_foreign_key "disbursement_payments", "disbursements"
  add_foreign_key "disbursement_requests", "applications"
  add_foreign_key "disbursements", "applications"
  add_foreign_key "disbursements", "funding_options"
  add_foreign_key "disbursements", "isas"
  add_foreign_key "disbursements", "student_academic_informations"
  add_foreign_key "docs_faqs", "docs_faqs"
  add_foreign_key "docs_faqs", "docs_generals"
  add_foreign_key "docs_fields", "docs_generals"
  add_foreign_key "docs_notes", "docs_generals"
  add_foreign_key "docs_notes", "users"
  add_foreign_key "eligibility_usas", "applications"
  add_foreign_key "form_attributes", "form_fields"
  add_foreign_key "form_inputs", "form_fields"
  add_foreign_key "form_list_dbs", "form_lists"
  add_foreign_key "form_list_values", "form_lists"
  add_foreign_key "fund_withdrawals", "isas"
  add_foreign_key "funding_disbursements", "funding_opportunities"
  add_foreign_key "funding_needs", "student_academic_informations"
  add_foreign_key "funding_opportunities", "funds"
  add_foreign_key "funding_opportunities", "modelings"
  add_foreign_key "funding_opportunities", "originations"
  add_foreign_key "funding_opportunity_invitations", "funding_opportunities"
  add_foreign_key "funding_opportunity_teams", "funding_opportunities"
  add_foreign_key "funding_opportunity_teams", "users"
  add_foreign_key "funding_option_configs", "funding_options"
  add_foreign_key "funding_option_disbursements", "disbursements"
  add_foreign_key "funding_option_disbursements", "funding_options"
  add_foreign_key "funding_option_statuses", "funding_option_configs"
  add_foreign_key "funding_options", "applications"
  add_foreign_key "funding_options", "modeling_fixed_conditions"
  add_foreign_key "funding_tokens", "funding_opportunities"
  add_foreign_key "funding_tokens", "student_token_batches"
  add_foreign_key "funding_tokens", "users"
  add_foreign_key "funds", "companies"
  add_foreign_key "funds", "funds"
  add_foreign_key "funds", "wompi_gateways"
  add_foreign_key "general_requests", "users"
  add_foreign_key "generate_matches", "generate_from_files"
  add_foreign_key "geographies", "geographies"
  add_foreign_key "geography_codes", "geographies"
  add_foreign_key "healths", "users"
  add_foreign_key "income_informations", "users"
  add_foreign_key "income_variable_incomes", "billing_documents"
  add_foreign_key "income_variable_incomes", "income_informations"
  add_foreign_key "indicator_cases", "companies"
  add_foreign_key "indicator_cases", "indicator_types"
  add_foreign_key "indicator_histories", "indicator_cases"
  add_foreign_key "indicator_inputs", "indicator_cases"
  add_foreign_key "indicator_references", "indicator_cases"
  add_foreign_key "indicator_repetitions", "indicator_cases"
  add_foreign_key "info_terpels", "users"
  add_foreign_key "invest_committees", "companies"
  add_foreign_key "invest_committees", "funding_opportunities"
  add_foreign_key "investment_decisions", "funding_options"
  add_foreign_key "investment_decisions", "invest_committees"
  add_foreign_key "investment_decisions", "users"
  add_foreign_key "ipcs", "countries"
  add_foreign_key "isa_amendment_disbursements", "disbursements"
  add_foreign_key "isa_amendment_disbursements", "isa_amendments"
  add_foreign_key "isa_amendments", "applications"
  add_foreign_key "isa_amendments", "isas"
  add_foreign_key "isa_amendments", "users"
  add_foreign_key "isa_statuses", "isas"
  add_foreign_key "isas", "collections", column: "employment_status_collection_trigger_id"
  add_foreign_key "isas", "funding_opportunities"
  add_foreign_key "isas", "funding_options"
  add_foreign_key "isas", "student_academic_informations"
  add_foreign_key "isas", "users"
  add_foreign_key "legal_documents", "companies"
  add_foreign_key "legal_documents", "legal_documents", column: "legal_documents_id"
  add_foreign_key "legal_matches", "applications"
  add_foreign_key "legal_matches", "legal_documents"
  add_foreign_key "legal_matches", "users"
  add_foreign_key "list_inputs", "form_lists"
  add_foreign_key "majors", "institutions"
  add_foreign_key "mentory_empleability_invitations", "users"
  add_foreign_key "mercado_pago_gateways", "companies"
  add_foreign_key "mercado_pago_responses", "mercado_pago_transactions"
  add_foreign_key "mercado_pago_transactions", "billing_documents"
  add_foreign_key "mercado_pago_transactions", "mercado_pago_gateways"
  add_foreign_key "migration_fields", "migrations"
  add_foreign_key "migration_jobs", "migrations"
  add_foreign_key "migration_picklists", "migration_fields"
  add_foreign_key "migration_trackings", "migration_jobs"
  add_foreign_key "migrations", "migrations"
  add_foreign_key "migrations_backups", "migrations"
  add_foreign_key "migrations_backups", "users"
  add_foreign_key "modeling_fees", "modelings"
  add_foreign_key "modeling_fixed_conditions", "modelings"
  add_foreign_key "modeling_flow_details", "modeling_flows"
  add_foreign_key "modeling_flow_extras", "modeling_flow_details"
  add_foreign_key "modeling_flow_fees", "modeling_fees"
  add_foreign_key "modeling_flow_fees", "modeling_flow_details"
  add_foreign_key "modeling_flow_summaries", "modeling_flows"
  add_foreign_key "modeling_flows", "funding_options"
  add_foreign_key "modeling_flows", "modelings"
  add_foreign_key "modeling_flows", "valuation_histories"
  add_foreign_key "modeling_matches", "applications"
  add_foreign_key "modeling_sencibilities", "modeling_main_sencibilities"
  add_foreign_key "modeling_sencibility_details", "funding_options"
  add_foreign_key "modeling_sencibility_details", "modeling_sencibilities"
  add_foreign_key "modeling_variables", "research_model_infos"
  add_foreign_key "modeling_variables", "users"
  add_foreign_key "modelings", "research_processes"
  add_foreign_key "notifications", "notification_cases"
  add_foreign_key "notifications", "users"
  add_foreign_key "origination_modules", "originations"
  add_foreign_key "origination_sections", "origination_modules"
  add_foreign_key "payment_agreements", "billing_documents"
  add_foreign_key "payment_agreements", "isas"
  add_foreign_key "payment_batches", "funds"
  add_foreign_key "payment_configs", "funding_opportunities"
  add_foreign_key "payment_excesses", "payments"
  add_foreign_key "payment_excesses", "users"
  add_foreign_key "payment_mass_details", "billing_documents"
  add_foreign_key "payment_mass_details", "funds"
  add_foreign_key "payment_mass_details", "payment_masses"
  add_foreign_key "payment_mass_details", "payments"
  add_foreign_key "payment_mass_docs", "billing_documents"
  add_foreign_key "payment_mass_docs", "disbursement_requests"
  add_foreign_key "payment_mass_docs", "funds"
  add_foreign_key "payment_mass_docs", "payment_mass_details"
  add_foreign_key "payment_masses", "companies"
  add_foreign_key "payment_originations", "companies"
  add_foreign_key "payment_originations", "funds"
  add_foreign_key "payments", "billing_documents"
  add_foreign_key "payments", "disbursements"
  add_foreign_key "payu_additional_infos", "payu_responses"
  add_foreign_key "payu_extra_params", "payu_responses"
  add_foreign_key "payu_gateways", "companies"
  add_foreign_key "payu_responses", "payu_transactions"
  add_foreign_key "payu_transactions", "billing_documents"
  add_foreign_key "payu_transactions", "payu_gateways"
  add_foreign_key "personal_covid_emergencies", "users"
  add_foreign_key "personal_informations", "users"
  add_foreign_key "pricing_details", "pricing_tables"
  add_foreign_key "pricing_tables", "funding_opportunities", column: "funding_opportunities_id"
  add_foreign_key "pricing_tables", "institutions", column: "institutions_id"
  add_foreign_key "pricing_vectors", "pricing_details"
  add_foreign_key "process_originations", "funding_opportunities"
  add_foreign_key "project_cards", "projects"
  add_foreign_key "project_comments", "project_tasks"
  add_foreign_key "project_comments", "users"
  add_foreign_key "project_favorites", "projects"
  add_foreign_key "project_favorites", "users"
  add_foreign_key "project_task_translates", "project_task_types"
  add_foreign_key "project_task_type_users", "project_task_types"
  add_foreign_key "project_task_type_users", "users"
  add_foreign_key "project_tasks", "companies"
  add_foreign_key "project_tasks", "project_cards"
  add_foreign_key "project_tasks", "project_task_types"
  add_foreign_key "project_teams", "projects"
  add_foreign_key "project_teams", "users"
  add_foreign_key "questionnaire_accumulations", "questionnaires"
  add_foreign_key "questionnaire_exceptions", "user_questionnaires"
  add_foreign_key "questionnaires", "companies"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "references", "users"
  add_foreign_key "requesting_modifications", "applications"
  add_foreign_key "research_inputs", "research_processes"
  add_foreign_key "research_model_infos", "research_variables"
  add_foreign_key "school_grades", "student_academic_informations"
  add_foreign_key "school_infos", "student_academic_informations"
  add_foreign_key "searchers", "users"
  add_foreign_key "signio_records", "users"
  add_foreign_key "social_works", "applications"
  add_foreign_key "social_works", "users"
  add_foreign_key "sociodemographics", "users"
  add_foreign_key "student_academic_informations", "applications"
  add_foreign_key "student_academic_informations", "institutions"
  add_foreign_key "student_academic_informations", "majors"
  add_foreign_key "student_academic_informations", "users"
  add_foreign_key "student_answers", "answers", column: "answers_id"
  add_foreign_key "student_answers", "student_scores"
  add_foreign_key "student_configs", "users"
  add_foreign_key "student_debts", "users"
  add_foreign_key "student_expenses", "student_financial_informations"
  add_foreign_key "student_financial_informations", "users"
  add_foreign_key "student_reviews", "users"
  add_foreign_key "student_routes", "team_profiles"
  add_foreign_key "student_scores", "questionnaires"
  add_foreign_key "student_token_batches", "funding_opportunities"
  add_foreign_key "support_roles", "companies"
  add_foreign_key "team_approvals", "roles"
  add_foreign_key "team_approvals", "team_profiles"
  add_foreign_key "team_profile_templates", "form_templates"
  add_foreign_key "team_profile_templates", "team_profiles"
  add_foreign_key "team_profiles", "form_templates"
  add_foreign_key "team_supervisors", "support_roles"
  add_foreign_key "university_course_grades", "university_grades"
  add_foreign_key "university_grades", "applications"
  add_foreign_key "university_grades", "disbursements"
  add_foreign_key "university_grades", "disbursements", column: "academic_bonus_id"
  add_foreign_key "university_grades", "student_academic_informations"
  add_foreign_key "university_infos", "student_academic_informations"
  add_foreign_key "user_aggregations", "users"
  add_foreign_key "user_questionnaire_answers", "answers"
  add_foreign_key "user_questionnaire_answers", "user_questionnaires"
  add_foreign_key "user_questionnaire_follow_ups", "user_questionnaires"
  add_foreign_key "user_questionnaire_scores", "questionnaires"
  add_foreign_key "user_questionnaire_scores", "user_questionnaires"
  add_foreign_key "user_questionnaires", "applications"
  add_foreign_key "user_questionnaires", "questionnaires"
  add_foreign_key "user_questionnaires", "users"
  add_foreign_key "user_scores", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "team_profiles"
  add_foreign_key "valuation_details", "valuation_histories"
  add_foreign_key "valuation_histories", "funds"
  add_foreign_key "valuation_histories", "users"
  add_foreign_key "wompi_gateways", "companies"
  add_foreign_key "wompi_responses", "wompi_transactions"
  add_foreign_key "wompi_transactions", "billing_documents"
  add_foreign_key "wompi_transactions", "wompi_gateways"
end
