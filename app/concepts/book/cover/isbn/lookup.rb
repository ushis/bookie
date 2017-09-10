require_dependency 'bookie/operation'

class Book < ApplicationRecord
  module Cover
    module ISBN
      class Lookup < Bookie::Operation
        ENDPOINT = 'http://bigbooksearch.com/query.php'

        PARAMS = {SearchIndex: 'all', ItemPage: 1}

        step :params!
        step :request!
        step :image!
        step :url!

        def params!(options, isbn:, **)
          options['params'] = PARAMS.merge(Keywords: isbn)
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
