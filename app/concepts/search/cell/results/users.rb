module Search
  module Cell
    class Results < Bookie::Cell
      class Users < Results

        def show
          render :results
        end

        private

        def results
          if users.empty?
            concept('search/cell/results/empty', nil, resource: :users, q: q)
          else
            concept('user/cell/cards', nil, users: users)
          end
        end

        def pagination
          concept('bookie/cell/pagination', users, params: {
            controller: :searches,
            action: :index,
            tab: :users,
            q: q,
          })
        end
      end
    end
  end
end
