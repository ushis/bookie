require_dependency 'bookie/cell'

module Search
  module Cell
    class Results < Bookie::Cell
      class Empty < Bookie::Cell

        def show
          concept('bookie/cell/info', message)
        end

        private

        def message
          I18n.t(tab, scope: 'search.results.empty.message', q: q)
        end

        def q
          options.fetch(:q).truncate(30)
        end

        def tab
          options.fetch(:tab)
        end
      end
    end
  end
end
