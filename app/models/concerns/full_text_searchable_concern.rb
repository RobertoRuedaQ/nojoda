# frozen_string_literal: true

module FullTextSearchableConcern
  extend ActiveSupport::Concern
  
  included do
    include PgSearch::Model

    def self.ransackable_scopes(auth_object = nil)
      %i[full_text_search]
    end
  end
end