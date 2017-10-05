module NetStub
  class Image

    def self.stub_request(url=nil)
      new(url).tap(&:stub).url
    end

    attr_reader :url

    def initialize(url=nil)
      @url = url.nil? ? random_url : url
    end

    def body
      image.read
    end

    def stub
      WebMock
        .stub_request(:get, url)
        .to_return(body: body, headers: {'Content-Type': 'image/png'})
    end

    private

    def random_url
      Faker::Internet.url
    end

    def image
      @image ||= Fixture::Image.new
    end
  end
end
