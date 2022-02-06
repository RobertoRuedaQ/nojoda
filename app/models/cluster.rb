class Cluster < ApplicationRecord
    resourcify
  audited
  belongs_to :major
end
