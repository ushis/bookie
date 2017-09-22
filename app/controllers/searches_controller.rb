class SearchesController < ApplicationController

  # GET /search
  def index
    result = run Search::Index

    render_concept('search/cell/index', nil, {
      q: result['q'],
      tab: result['tab'],
      books: result['books'],
      users: result['users'],
      context: {
        q: result['q'],
        tab: result['tab'],
      },
    })
  end
end
