require_dependency 'book/copy/guard/create'

class Book < ApplicationRecord
  module Copy
    module Guard
      class Destroy < Create
      end
    end
  end
end
