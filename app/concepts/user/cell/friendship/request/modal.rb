require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Cell
    module Friendship
      module Request
        class Modal < Bookie::Cell

          def show
            super if show?
          end

          private

          def show?
            User::Friendship::Request::Guard::Create.({
              model: model,
              current_user: current_user,
            })
          end

          def id
            'friendship-request-modal'
          end

          def classes
            contract.valid? ? %w() : %w(is-active)
          end

          def contract
            options.fetch(:contract)
          end

          def url
            create_friendship_request_user_path(model)
          end
        end
      end
    end
  end
end
