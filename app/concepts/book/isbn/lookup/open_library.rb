class Book < ApplicationRecord
  module ISBN
    class Lookup < Bookie::Operation
      class OpenLibrary < Bookie::Operation
        ENDPOINT = 'https://openlibrary.org/api/books'

        PARAMS = {
          format: 'json',
          jscmd: 'data',
        }

        step :params!
        step :request!
        step :data!
        step :check!
        step :attributes!

        def params!(options, isbn:, **)
          options['params'] = PARAMS.merge(bibkeys: "ISBN:#{isbn}")
        end

        def request!(options, params:, **)
          options['response'] = RestClient.get(ENDPOINT, params: params)
        end

        def data!(options, response:, isbn:, **)
          options['data'] = JSON.parse(response)["ISBN:#{isbn}"]
        rescue JSON::ParserError
          false
        end

        def check!(options, data:, isbn:, **)
          data.dig('identifiers', 'isbn_13').try(:any?) { |id| id == isbn }
        end

        def attributes!(options, data:, isbn:, **)
          options['attributes'] = {
            isbn: isbn,
            title: data['title'],
            authors: data['authors'].map { |author| author['name'] }.join(', '),
          }
        end
      end
    end
  end
end
