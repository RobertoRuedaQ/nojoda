class DocsFaq < ApplicationRecord
      
      resourcify
      audited
  belongs_to :docs_general
  belongs_to :docs_faq
end
