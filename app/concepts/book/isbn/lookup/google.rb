class Book < ApplicationRecord
  module ISBN
    class Lookup < Bookie::Operation
      class Google < Bookie::Operation
        ENDPOINT = 'https://www.googleapis.com/books/v1/volumes'

        step :params!
        step :request!
        step :payload!
        step :data!
        step :attributes!

        def params!(options, isbn:, **)
          options['params'] = {q: "isbn:#{isbn}"}
        end

        def request!(options, params:, **)
          options['response'] = RestClient.get(ENDPOINT, params: params)
        end

        def payload!(options, response:, **)
          options['payload'] = JSON.parse(response)
        rescue JSON::ParserError
          false
        end

        def data!(options, payload:, isbn:, **)
          options['data'] = payload.fetch('items', []).find { |item|
            item.dig('volumeInfo', 'industryIdentifiers').any? { |id|
              id['type'] == 'ISBN_13' && id['identifier'] == isbn
            }
          }
        end

        def attributes!(options, data:, isbn:, **)
          options['attributes'] = {
            isbn: isbn,
            title: data.dig('volumeInfo', 'title'),
            authors: data.dig('volumeInfo', 'authors').try(:join, ', '),
          }
        end
      end
    end
  end
end
