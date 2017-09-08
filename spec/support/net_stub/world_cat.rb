module NetStub
  class WorldCat
    ENDPOINT = 'http://xisbn.worldcat.org/webservices/xid/isbn/:isbn'

    PARAMS = {
      method: 'getMetadata',
      format: 'json',
      fl: 'title,author',
    }

    def self.stub_request(isbn, items=nil)
      new(isbn, items).tap(&:stub).items
    end

    attr_reader :isbn, :items

    def initialize(isbn, items=nil)
      @isbn = isbn
      @items = items.nil? ? random_items : Array.wrap(items)
    end

    def stub
      WebMock
        .stub_request(:get, url)
        .with(query: PARAMS)
        .to_return(body: body, headers: {'Content-Type': 'application/json'})
    end

    private

    def url
      ENDPOINT.sub(':isbn', isbn)
    end

    def body
      items.empty? ? empty_body : body_with_items
    end

    def empty_body
      {
        stat: 'unknownId'
      }.to_json
    end

    def body_with_items
      {
        stat: 'ok',
        list: items.map { |item|
          {
            isbn: [item[:isbn]],
            title: item[:title],
            author: item[:authors],
          }
        },
      }.to_json
    end

    def random_items
      (1..3).sample.times.map { |_| random_item }
    end

    def random_item
      {
        isbn: isbn,
        title: Factory::Book.title,
        authors: Factory::Book.authors,
      }
    end
  end
end
