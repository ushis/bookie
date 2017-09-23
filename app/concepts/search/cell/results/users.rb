module Search
  module Cell
    class Results < Bookie::Cell
      class Users < Results

        def show
          render(:results)
        end

        private

        def models
          options.fetch(:users)
        end

        def plate(user)
          concept('user/cell/plate', user)
        end
      end
    end
  end
end
