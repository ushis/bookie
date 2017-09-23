module Search
  module Cell
    class Results < Bookie::Cell
      class Books < Results

        def show
          render(:results)
        end

        private

        def models
          options.fetch(:books)
        end

        def plate(book)
          concept('book/cell/plate', book)
        end
      end
    end
  end
end
