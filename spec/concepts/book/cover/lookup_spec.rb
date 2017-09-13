require 'rails_helper'

RSpec.describe Book::Cover::Lookup do
  let(:result) { Book::Cover::Lookup.(nil, isbn: isbn) }

  let(:isbn) { Factory::Book.isbn }

  before { NetStub::BigBookSearch.stub_request(isbn, cover_url) }

  let(:cover_url) { NetStub::Image.stub_request }

  it 'successfully creates a cover and its versions' do
    expect(result).to be_success
    expect(result['model']).to be_persisted

    Book::Cover::Proxy::Default.new(result['model']).tap do |proxy|
      expect(proxy.image[:small]).to be_present
      expect(proxy.image[:large]).to be_present
      expect(proxy.image[:small_preview]).to be_present
      expect(proxy.image[:large_preview]).to be_present
    end
  end

  context 'when nothing was found' do
    let(:cover_url) { [] }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'when a cover for the given isbn already exists' do
    let!(:cover) { Book::Cover::Lookup.(nil, isbn: isbn)['model'] }

    it 'successfully finds the cover' do
      expect(result).to be_success
      expect(result['model']).to eq(cover)
    end
  end
end
