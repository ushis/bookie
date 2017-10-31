require 'rails_helper'

RSpec.describe Bookie::Cell::Tabs, type: :cell do
  let(:cell) { concept('bookie/cell/tabs', nil, dependencies).() }

  let(:dependencies) { {tabs: [a, b, c], active: active, style: style} }

  let(:a) { {id: :a, url: '/a', name: 'A', counter: 1} }

  let(:b) { {id: :b, url: '/b', name: 'B', counter: 2} }

  let(:c) { {id: :c, url: '/c', name: 'C'} }

  let(:active) { :b }

  let(:style) { [:toggle, :small] }

  it 'renders all tabs' do
    # check style
    expect(cell).to have_selector('.tabs.is-toggle.is-small')

    # check tabs
    expect(cell).to have_selector('.tabs ul li a[href="/a"]', text: 'A')
    expect(cell).to have_selector('.tabs ul li a[href="/b"]', text: 'B')
    expect(cell).to have_selector('.tabs ul li a[href="/c"]', text: 'C')

    # check counters
    expect(cell).to have_selector('.tabs ul li a[href="/a"] .counter', text: 1)
    expect(cell).to have_selector('.tabs ul li a[href="/b"] .counter', text: 2)
    expect(cell).to_not have_selector('.tabs ul li a[href="/c"] .counter')

    # check active state
    expect(cell).to have_selector('.tabs ul li:not(.is-active) a[href="/a"]')
    expect(cell).to have_selector('.tabs ul li.is-active a[href="/b"]')
    expect(cell).to have_selector('.tabs ul li:not(.is-active) a[href="/c"]')
  end
end
