require 'rails_helper'

RSpec.describe Book::ISBN::Lookup do
  let(:result) { Book::ISBN::Lookup.(nil, isbn: isbn) }

  let(:isbn) { Factory::Book.isbn }

  before { NetStub::GoogleBooks.stub_request(isbn, google_response) }

  before { NetStub::WorldCat.stub_request(isbn, world_cat_response) }

  before { NetStub::OpenLibrary.stub_request(isbn, open_library_response) }

  let(:google_response) {
    {
      isbn: isbn,
      title: Factory::Book.title,
      authors: Factory::Book.authors,
    }
  }

  let(:world_cat_response) {
    {
      isbn: isbn,
      title: Factory::Book.title,
      authors: Factory::Book.authors,
    }
  }

  let(:open_library_response) {
    {
      isbn: isbn,
      title: Factory::Book.title,
      authors: Factory::Book.authors,
    }
  }

  it 'successfully returns the data from google' do
    expect(result).to be_success
    expect(result['attributes']).to eq(google_response)
  end

  context 'when google responds with nothing' do
    let(:google_response) { [] }

    it 'successfully returns the data from world cat' do
      expect(result).to be_success
      expect(result['attributes']).to eq(world_cat_response)
    end

    context 'when world cat responds with nothing' do
      let(:world_cat_response) { [] }

      it 'successfully returns the data from open library' do
        expect(result).to be_success
        expect(result['attributes']).to eq(open_library_response)
      end

      context 'when open library responds with nothing' do
        let(:open_library_response) { nil }

        it 'fails' do
          expect(result).to be_failure
        end
      end
    end
  end
end
