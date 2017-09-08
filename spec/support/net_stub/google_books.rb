module NetStub
  class GoogleBooks
    ENDPOINT = 'https://www.googleapis.com/books/v1/volumes'

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
        .stub_request(:get, ENDPOINT)
        .with(query: params)
        .to_return(body: body, headers: {'Content-Type': 'application/json'})
    end

    private

    def params
      {q: "isbn:#{isbn}"}
    end

    def body
      {
        kind: 'books#volumes',
        totalItems: items.size,
        items: items.map { |item|
          {
            volumeInfo: {
              title: item[:title],
              authors: Array.wrap(item[:authors]),
              industryIdentifiers: [{
                type: 'ISBN_13',
                identifier: item[:isbn],
              }],
            },
          }
        },
      }.to_json
    end

    def random_items
      rand(1..3).times.map { |_| random_item }
    end

    def random_item
      {
        isbn: isbn,
        title: Factory::Book.title,
        authors: rand(1..3).times.map { |_| Factory::Book.authors },
      }
    end
  end
end
