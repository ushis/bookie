require_dependency 'bookie/search/results'

module Bookie
  class Search
    class Query
      delegate_missing_to :results

      def initialize(client, index:, query:, page:1, per:30, pad:1)
        @client = client
        @index = index
        @query = query
        @page = page
        @per = per
        @pad = pad
      end

      def page
        [@page, 1].max
      end

      def per
        [@per, 1].max
      end

      def results
        @results ||= Results.new(self, @client.search({
          index: @index,
          body: {query: @query},
          stored_fields: [:_id],
          size: _size,
          from: _from,
        }))
      end

      private

      def _size
        (per * @pad).ceil
      end

      def _from
        (page - 1) * per
      end
    end
  end
end
