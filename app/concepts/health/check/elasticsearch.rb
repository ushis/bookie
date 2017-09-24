require_dependency 'health/check'

module Health
  class Check
    class Elasticsearch < Check

      def call
        @error = 'Elasticsearch is not available' if !Bookie::Search.ping
      end
    end
  end
end
