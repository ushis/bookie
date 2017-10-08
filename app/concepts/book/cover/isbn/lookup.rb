require_dependency 'bookie/operation'

class Book < ApplicationRecord
  module Cover
    module ISBN
      class Lookup < Bookie::Operation
        ENDPOINT = 'http://bigbooksearch.com/query.php'

        PARAMS = {SearchIndex: 'all', ItemPage: 1}

        success :convert!
        step :keywords!
        step :params!
        step :request!
        step :image!
        step :url!

        def convert!(options, isbn:, **)
          options['isbn_10'] = Book::ISBN::Convert::ISBN13.(nil, {
            isbn: isbn,
          })['isbn_10']
        end

        def keywords!(options, isbn:, isbn_10:, **)
          options['keywords'] = [isbn, isbn_10].compact.join(' ')
        end

        def params!(options, keywords:, **)
          options['params'] = PARAMS.merge(Keywords: keywords)
        end

        def request!(options, params:, **)
          options['response'] = RestClient.get(ENDPOINT, params: params)
        end

        def image!(options, response:, **)
          options['image'] = Nokogiri::HTML(response).css('a img').first
        end

        def url!(options, image:, **)
          options['url'] = image.attributes['src'].try(:value)
        end
      end
    end
  end
end
