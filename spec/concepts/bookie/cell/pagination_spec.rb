require 'rails_helper'

RSpec.describe Bookie::Cell::Pagination, type: :cell do
  controller ApplicationController

  let(:cell) { concept('bookie/cell/pagination', scope, params: params).() }

  let(:params) { {controller: :books, action: :index} }

  let(:scope) {
    scope_class.new(
      total_pages,
      prev_page,
      next_page,
      first_page?,
      last_page?
    )
  }

  let(:scope_class) {
    Struct.new(
      :total_pages,
      :prev_page,
      :next_page,
      :first_page?,
      :last_page?
    )
  }

  let(:total_pages) { current_page + rand(1..10) }

  let(:prev_page) { current_page - 1 }

  let(:next_page) { current_page + 1 }

  let(:first_page?) { current_page == 1 }

  let(:last_page?) { current_page == total_pages }

  let(:current_page) { rand(2..100) }

  it 'has active links to the previous and the next page' do
    expect(cell).to have_selector('.bookie-pagination a:not(.disabled)', text: 'Previous Page')
    expect(cell).to have_selector('.bookie-pagination a:not(.disabled)', text: 'Next Page')
  end

  context 'when current page ist the first page' do
    let(:current_page) { 1 }

    it 'has a disabled link to the previous page' do
      expect(cell).to have_selector('.bookie-pagination a.disabled', text: 'Previous Page')
      expect(cell).to have_selector('.bookie-pagination a:not(.disabled)', text: 'Next Page')
    end
  end

  context 'when current page ist the last page' do
    let(:total_pages) { current_page }

    it 'has a disabled link to the next page' do
      expect(cell).to have_selector('.bookie-pagination a:not(.disabled)', text: 'Previous Page')
      expect(cell).to have_selector('.bookie-pagination a.disabled', text: 'Next Page')
    end
  end

  context 'when there is no or only one page' do
    let(:total_pages) { [0, 1].sample }

    it 'renders nothing' do
      expect(cell).to_not have_selector('.bookie-pagination')
    end
  end
end
