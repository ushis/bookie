require_dependency 'health/check'

module Health
  class Check
    class S3 < Check

      def call
        @error = 'S3 bucket does not exist' if !bucket_exists?
      rescue StandardError => err
        @error = err.message
      end

      private

      def bucket_exists?
        ::Dragonfly.app.datastore.bucket_exists?
      end
    end
  end
end
