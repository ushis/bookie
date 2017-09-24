require 'sidekiq/api'

require_dependency 'health/check'

module Health
  class Check
    class Sidekiq < Check

      def call
        @error = 'Sidekiq is not running.' if processes < 1
      rescue StandardError => err
        @error = err.message
      end

      private

      def processes
        ::Sidekiq::Stats.new.processes_size
      end
    end
  end
end
