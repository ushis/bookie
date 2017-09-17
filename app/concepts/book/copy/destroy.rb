require_dependency 'book/copy/guard/destroy'
require_dependency 'bookie/operation'
require_dependency 'copy'

class Book < ApplicationRecord
  module Copy
    class Destroy < Bookie::Operation
      step self::Policy::Guard(Guard::Destroy)
      step :book!
      step :model!
      step :destroy!

      def book!(options, params:, **)
        options['book'] = Book.find_by(id: params[:book_id])
      end

      def model!(options, book:, current_user:, **)
        options['model'] = ::Copy.find_by(book: book, owner: current_user)
        options['model'].present? ? true : Railway.pass_fast!
      end

      def destroy!(options, model:, **)
        model.destroy
      end
    end
  end
end
