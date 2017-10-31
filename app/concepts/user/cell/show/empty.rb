require_dependency 'user/cell/show'

class User < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      class Empty < Show

        def show
          super { concept('bookie/cell/info', message) }
        end

        private

        def message
          I18n.t(tab, scope: 'user.show.empty.message')
        end
      end
    end
  end
end
