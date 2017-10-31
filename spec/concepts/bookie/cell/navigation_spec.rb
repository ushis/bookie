require 'rails_helper'

RSpec.describe Bookie::Cell::Navigation, type: :cell do
  let(:cell) { concept('bookie/cell/navigation', nil, dependencies).() }

  let(:dependencies) { {items: [a, b, c], active: active, title: title} }

  let(:a) { {id: :a, url: '/a', name: 'A', icon: 'squirrel'} }

  let(:b) { {id: :b, url: '/b', name: 'B', icon: 'rocket'} }

  let(:c) { {id: :c, url: '/c', name: 'C', icon: 'flame'} }

  let(:active) { :c }

  let(:title) { Faker::Lorem.word }

  it 'renders a panel navigation' do
    # check title
    expect(cell).to have_selector('nav.panel .panel-heading', text: title)

    # check items
    expect(cell).to have_selector('.panel a.panel-block[href="/a"]', text: 'A')
    expect(cell).to have_selector('.panel a.panel-block[href="/b"]', text: 'B')
    expect(cell).to have_selector('.panel a.panel-block[href="/c"]', text: 'C')

    # check icons
    expect(cell).to \
      have_selector('.panel a.panel-block[href="/a"] .panel-icon .octicon-squirrel')

    expect(cell).to \
      have_selector('.panel a.panel-block[href="/b"] .panel-icon .octicon-rocket')

    expect(cell).to \
      have_selector('.panel a.panel-block[href="/c"] .panel-icon .octicon-flame')

    # check active state
    expect(cell).to have_selector('.panel a.panel-block:not(.is-active)[href="/a"]')
    expect(cell).to have_selector('.panel a.panel-block:not(.is-active)[href="/b"]')
    expect(cell).to have_selector('.panel a.panel-block.is-active[href="/c"]')
  end
end
