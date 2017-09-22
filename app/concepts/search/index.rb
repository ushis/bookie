require_dependency 'bookie/operation'

module Search
  class Index < Bookie::Operation
    TABS = %w(books users)

    step :q!
    step :tab!
    step :page!
    step :books!
    step :users!

    def q!(options, params:, **)
      options['q'] = params[:q].to_s
    end

    def tab!(options, params:, **)
      options['tab'] = TABS.find { |tab| tab == params[:tab] } || TABS.first
    end

    def page!(options, params:, **)
      options['page'] = params[:page].to_i
    end

    def books!(options, q:, page:, **)
      options['books'] = Book
        .includes(:cover)
        .search({
          index: 'books',
          query: {
            bool: {
              should: [
                {match: {isbn: q}},
                {match: {title: q}},
                {match: {authors: q}},
              ],
            },
          },
          page: page,
          per: 30,
        })
    end

    def users!(options, q:, page:, **)
      options['users'] = User
        .includes(:avatar)
        .search({
          index: 'users',
          query: {
            match: {username: q},
          },
          page: page,
          per: 30,
        })
    end
  end
end
