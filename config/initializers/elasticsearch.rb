module Elasticsearch
  class Config
    class << self

      def client
        {
          url: ENV['ELASTICSEARCH_URL'],
          log: true,
          logger: Rails.logger,
        }
      end

      def indices
        config['indices']
      end

      private

      def config
        @config ||= YAML.load_file(Rails.root.join('config', 'elasticsearch.yml'))
      end
    end
  end
end
