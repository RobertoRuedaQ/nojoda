class Searcher < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
