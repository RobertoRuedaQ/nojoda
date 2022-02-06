class IndicatorInput < ApplicationRecord
  resourcify
  audited
  belongs_to :source, class_name: 'IndicatorCase', foreign_key: 'source_id'
  belongs_to :destination, class_name: 'IndicatorCase', foreign_key: 'destination_id'
end
