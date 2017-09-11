class BooksController < ApplicationController

  # GET /
  def index
    run Book::Index do |result|
      render_concept('book/cell/index', nil, {
        q: result['q'],
        books: result['books'],
        context: {
          q: result['q'],
        },
      })
    end
  end

  # GET /books/:id
  def show
    run Book::Find do |result|
      render_concept('book/cell/show', result['model'])
      return
    end

    redirect_to root_url
  end

  # GET /books/lookup
  def lookup_form
    run Book::Lookup::New do |result|
      render_concept('book/cell/lookup', nil, {
        contract: result['contract.lookup'],
      })
      return
    end

    redirect_to root_url
  end

  # POST /books/lookup
  def lookup
    Book::Endpoint::Lookup.(run(Book::Lookup)) do |m|
      m.success {
        redirect_to book_url(result['model'])
      }

      m.unauthorized {
        redirect_to root_url
      }

      m.invalid_isbn {
        render_concept('book/cell/lookup', nil, {
          contract: result['contract.lookup'],
        })
      }

      m.not_found {
        render_concept('book/cell/new', nil, {
          contract: result['contract.lookup'],
        })
      }

      m.invalid_attributes {
        render_concept('book/cell/new', nil, {
          contract: result['contract.default'],
        })
      }
    end
  end

  # POST /books
  def create
    Book::Endpoint::Create.(run(Book::Create)) do |m|
      m.success {
        redirect_to book_url(result['model'])
      }

      m.unauthorized {
        redirect_to root_url
      }

      m.invalid {
        render_concept('book/cell/new', nil, {
          contract: result['contract.default'],
        })
      }
    end
  end
end
