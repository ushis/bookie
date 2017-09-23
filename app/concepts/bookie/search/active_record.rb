require_dependency 'bookie/search'
require_dependency 'bookie/search/active_record/request'

module Bookie
  class Search
    module ActiveRecord

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def search(definition)
          Request.new(all, Bookie::Search.query(definition.reverse_merge({
            pad: 1.1,
          })))
        end
      end
    end
  end
end
