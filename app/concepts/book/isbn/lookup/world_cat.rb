class Book < ApplicationRecord
  module ISBN
    class Lookup < Bookie::Operation
      class WorldCat < Bookie::Operation
        ENDPOINT = 'http://xisbn.worldcat.org/webservices/xid/isbn/:isbn'

        PARAMS = {
          method: 'getMetadata',
          format: 'json',
          fl: 'title,author',
        }

        step :url!
        step :request!
        step :payload!
        step :ok?
        step :data!
        step :attributes!

        def url!(options, isbn:, **)
          options['url'] = ENDPOINT.sub(':isbn', isbn)
        end

        def request!(options, url:, **)
          options['response'] = RestClient.get(url, params: PARAMS)
        end

        def payload!(options, response:, **)
          options['payload'] = JSON.parse(response)
        rescue JSON::ParserError
          false
        end

        def ok?(options, payload:, **)
          payload['stat'] == 'ok'
        end

        def data!(options, payload:, isbn:, **)
          options['data'] = payload['list'].find { |item|
            item['isbn'].any? { |id| id == isbn }
          }
        end

        def attributes!(options, data:, isbn:, **)
          options['attributes'] = {
            isbn: isbn,
            title: data['title'],
            authors: data['author'],
          }
        end
      end
    end
  end
end
