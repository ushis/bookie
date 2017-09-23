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
      expect(proxy.image[:original]).to be_present
      expect(proxy.image[:small].fetch.width).to eq(100)
      expect(proxy.image[:large].fetch.width).to eq(300)

      proxy.image[:small_preview].fetch do |version|
        expect(version.width).to eq(100)
        expect(version.height).to eq(150)
      end

      proxy.image[:large_preview].fetch do |version|
        expect(version.width).to eq(300)
        expect(version.height).to eq(450)
      end
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
