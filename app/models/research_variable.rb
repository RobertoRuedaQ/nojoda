class ResearchVariable < ApplicationRecord
      
      resourcify
      audited
	  belongs_to :parent,:class_name => 'ResearchVariable', foreign_key: 'parent_id',optional: true
	  has_many :children,:class_name => 'ResearchVariable', foreign_key: 'parent_id', dependent: :destroy
  has_many :variable,:class_name => 'ResearchFilter', foreign_key: 'variable_id', dependent: :destroy
  has_many :filter,:class_name => 'ResearchFilter', foreign_key: 'filter_id', dependent: :destroy
  has_many :migration_accumulation, as: :resource , dependent: :destroy
  has_many :research_model_info, dependent: :destroy

end
