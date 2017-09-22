module Bookie
  class Search
    class Results

      def initialize(query, response)
        @query = query
        @response = response
      end

      def ids
        @response['hits']['hits'].map { |hit| Integer(hit['_id']) }
      end

      def total_count
        @response['hits']['total']
      end

      def total_pages
        total_count.fdiv(@query.per).ceil
      end

      def current_page
        @query.page
      end

      def next_page
        (current_page < total_pages || out_of_range?) ? current_page + 1 : nil
      end

      def prev_page
        (current_page > 1 || out_of_range?) ? current_page - 1 : nil
      end

      def first_page?
        current_page == 1
      end

      def last_page?
        current_page == total_pages
      end

      def out_of_range?
        current_page > total_pages
      end
    end
  end
end
