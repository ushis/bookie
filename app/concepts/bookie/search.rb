require_dependency 'bookie/search/query'

module Bookie
  class Search
    class << self

      def client
        @client ||= Elasticsearch::Client.new(config[:client])
      end

      def query(*args)
        Query.new(client, *args)
      end

      def index(*args)
        client.index(*args)
      end

      def create_indices(force:false)
        config[:indices].each_key { |index|
          create_index(index: index, force: force)
        }
      end

      def delete_indices
        config[:indices].each_key { |index| delete_index(index: index) }
      end

      def create_index(index:, force:false)
        delete_index(index: index) if force
        client.indices.create(index: index, body: config[:indices][index])
      end

      def delete_index(index:)
        client.indices.delete(index: index) if client.indices.exists?(index: index)
      end

      private

      def config
        Elasticsearch::Config
      end
    end
  end
end
