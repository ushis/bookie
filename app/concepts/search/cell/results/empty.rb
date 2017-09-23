require_dependency 'bookie/cell'

module Search
  module Cell
    class Results < Bookie::Cell
      class Empty < Bookie::Cell

        private

        def message
          I18n.t('search.results.empty', resource: resource, q: q)
        end

        def resource
          I18n.t(options.fetch(:resource), scope: 'search.resources')
        end

        def q
          options.fetch(:q).truncate(30)
        end
      end
    end
  end
end
