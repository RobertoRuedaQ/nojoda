class DocsNote < ApplicationRecord
      
      resourcify
      audited
  belongs_to :docs_general
  belongs_to :user
end
