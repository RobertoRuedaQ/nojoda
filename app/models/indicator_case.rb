class IndicatorCase < ApplicationRecord
  resourcify
  audited
  belongs_to :indicator_type
  has_many :indicator_repetition, dependent: :destroy
  has_many :indicator_history, dependent: :destroy
  has_many :sources, class_name: 'IndicatorCase', foreign_key: 'source_id', dependent: :destroy
  has_many :inputs,class_name: 'IndicatorCase', foreign_key: 'destination_id', dependent: :destroy
  has_many :indicator_reference, dependent: :destroy

end
