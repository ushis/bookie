require_dependency 'book/copy/guard/create'
require_dependency 'book/copy/guard/destroy'
require_dependency 'bookie/cell'

class Book < ApplicationRecord
  module Cell
    class Show < Bookie::Cell
      property :title

      private

      def cover
        concept('book/cell/cover', model, version: :large)
      end

      def authors
        "by #{model.authors}" if model.authors.present?
      end

      def show_button_to_create_copy?
        Book::Copy::Guard::Create.call(current_user: current_user) &&
          !current_user.books.include?(model)
      end

      def button_to_create_copy
        # FIXME Bookie::Cell::IconButton
        button_to(copies_path, {
          params: {book_id: model.id},
          class: 'btn btn-success btn-sm',
        }) {
          concat(octicon(:check, height: 14))
          concat(content_tag(:span, 'I have this book'))
        }
      end

      def show_button_to_destroy_copy?
        Book::Copy::Guard::Destroy.call(current_user: current_user) &&
          current_user.books.include?(model)
      end

      def button_to_destroy_copy
        # FIXME Bookie::Cell::IconButton
        button_to(copies_path, {
          method: :delete,
          params: {book_id: model.id},
          class: 'btn btn-danger btn-sm',
        }) {
          concat(octicon(:x, height: 14))
          concat(content_tag(:span, 'I lost it'))
        }
      end
    end
  end
end
