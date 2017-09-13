require_relative './image'

module NetStub
  class RoboHash < Image
    ENDPOINT = 'https://robohash.org/:key?bgset=bg2'

    def self.stub_request(*keys)
      new(keys).tap(&:stub).keys
    end

    attr_reader :keys

    def initialize(*keys)
      @keys = keys.empty? ? random_keys : keys
    end

    def url
      ENDPOINT.sub(':key', Digest::SHA1.hexdigest(keys.join('-')))
    end

    private

    def random_keys
      [Faker::Internet.user_name, Faker::Internet.email]
    end
  end
end
