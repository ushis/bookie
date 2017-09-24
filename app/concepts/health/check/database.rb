require_dependency 'health/check'

module Health
  class Check
    class Database < Check

      def call
        ActiveRecord::Migrator.current_version
      rescue StandardError => err
        @error = err.message
      end
    end
  end
end
