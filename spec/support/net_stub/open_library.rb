module NetStub
  class OpenLibrary
    ENDPOINT = 'https://openlibrary.org/api/books'

    PARAMS = {
      format: 'json',
      jscmd: 'data',
    }

    def self.stub_request(isbn, item=:random)
      new(isbn, item).tap(&:stub).item
    end

    attr_reader :isbn, :item

    def initialize(isbn, item=:random)
      @isbn = isbn
      @item = (item == :random) ? random_item : item
    end

    def stub
      WebMock
        .stub_request(:get, ENDPOINT)
        .with(query: params)
        .to_return(body: body, headers: {'Content-Type': 'application/json'})
    end

    private

    def params
      PARAMS.merge(bibkeys: "ISBN:#{isbn}")
    end

    def body
      item.nil? ? empty_body : body_with_item
    end

    def empty_body
      {}.to_json
    end

    def body_with_item
      {
        "ISBN:#{isbn}": {
          identifiers: {
            isbn_13: [item[:isbn]],
          },
          title: item[:title],
          authors: Array.wrap(item[:authors]).map { |author|
            {name: author}
          },
        },
      }.to_json
    end

    def random_item
      {
        isbn: Factory::Book.isbn,
        title: Factory::Book.title,
        authors: Factory::Book.authors,
      }
    end
  end
end
