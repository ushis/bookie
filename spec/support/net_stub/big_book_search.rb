module NetStub
  class BigBookSearch
    ENDPOINT = 'http://bigbooksearch.com/query.php'

    PARAMS = {ItemPage: 1, SearchIndex: 'all'}

    def self.stub_request(isbn, urls=nil)
      new(isbn, urls).tap(&:stub).urls
    end

    attr_reader :isbn, :urls

    def initialize(isbn, urls=nil)
      @isbn = isbn.to_s
      @urls = urls.nil? ? random_urls : Array.wrap(urls)
    end

    def stub
      WebMock
        .stub_request(:get, ENDPOINT)
        .with(query: params)
        .to_return(body: body)
    end

    private

    def params
      PARAMS.merge(Keywords: keywords)
    end

    def keywords
      [isbn, isbn_10].compact.join(' ')
    end

    def isbn_10
      Book::ISBN::Convert::ISBN13.(nil, isbn: isbn)['isbn_10']
    end

    def body
      urls.empty? ? empty_body : body_with_urls
    end

    def empty_body
      'no_results'
    end

    def body_with_urls
      urls.map { |url| "<a href='#{random_url}'><img src='#{url}'></a>" }.join
    end

    def random_urls
      Array.new(rand(1..3)) { |_| random_url }
    end

    def random_url
      Faker::Internet.url
    end
  end
end
