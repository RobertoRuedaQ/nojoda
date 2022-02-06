class Country < ApplicationRecord
  resourcify
  audited

  has_many :company
  has_many :ipc
  after_commit :flush_country
  has_one_attached :flag
  has_many :default_matrix

  def flush_country
  	Rails.cache.fetch(['company_cached_currency',self.id])
  	Rails.cache.fetch(['cached_company_precision',self.id])
  end
end
