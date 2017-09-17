require_dependency 'book/copy/guard/create'
require_dependency 'bookie/operation'
require_dependency 'copy'

class Book < ApplicationRecord
  module Copy
    class Create < Bookie::Operation
      step self::Policy::Guard(Guard::Create)
      step :book!
      step :model!
      step :save!

      def book!(options, params:, **)
        options['book'] = Book.find_by(id: params[:book_id])
      end

      def model!(options, book:, current_user:, **)
        options['model'] = ::Copy.find_or_initialize_by(book: book, owner: current_user)
        options['model'].persisted? ? Railway.pass_fast! : true
      end

      def save!(options, model:, **)
        model.save
      end
    end
  end
end
