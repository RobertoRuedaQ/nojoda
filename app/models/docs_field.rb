class DocsField < ApplicationRecord
      
      resourcify
      audited
  belongs_to :docs_general
end
