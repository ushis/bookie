module Search
  class Client
    class << self
      delegate :count, :index, :indices, :search, to: :client

      private

      # FIXME: configurable credentials
      def client
        @client ||= Elasticsearch::Client.new({
          host: 'elasticsearch',
          user: 'elastic',
          password: 'changeme',
          log: true,
          logger: Rails.logger,
        })
      end
    end
  end
end
