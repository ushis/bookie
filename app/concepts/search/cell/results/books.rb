module Search
  module Cell
    class Results < Bookie::Cell
      class Books < Results

        def show
          render :results
        end

        private

        def results
          if books.empty?
            concept('search/cell/results/empty', nil, resource: :books, q: q)
          else
            concept('book/cell/cards', nil, books: books)
          end
        end

        def pagination
          concept('bookie/cell/pagination', books, params: {
            controller: :searches,
            action: :index,
            tab: :books,
            q: q,
          })
        end
      end
    end
  end
end
