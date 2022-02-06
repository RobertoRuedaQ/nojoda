class FormListDb < ApplicationRecord
      
      resourcify
      audited
  belongs_to :form_list
  has_many :form_label, as: :resource , dependent: :destroy

  after_commit :flush_form_list_db

  def flush_form_list_db
    Rails.cache.clear
  end

end
