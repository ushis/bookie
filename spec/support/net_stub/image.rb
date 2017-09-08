module NetStub
  class Image

    def self.stub_request(url)
      new(url).tap(&:stub).url
    end

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def stub
      WebMock
        .stub_request(:get, url)
        .to_return(body: jpg, headers: {'Content-Type': 'image/jpeg'})
    end

    private

    def jpg
      Base64.decode64(
        "/9j/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8M\n" \
        "CgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/yQALCAABAAEBAREA/8wABgAQ\n" \
        "EAX/2gAIAQEAAD8A0s8g/9k="
      )
    end
  end
end
