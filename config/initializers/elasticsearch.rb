module Elasticsearch
  class Config
    class << self

      def [](key)
        config[key]
      end

      private

      def config
        @config ||= default.deep_merge(raw.deep_symbolize_keys)
      end

      def default
        {client: {log: true, logger: Rails.logger}}
      end

      def raw
        YAML.safe_load(yaml, [], [], true)
      end

      def yaml
        ERB.new(file).result
      end

      def file
        Rails.root.join('config', 'elasticsearch.yml').read
      end
    end
  end
end
