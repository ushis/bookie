require 'rails_helper'

RSpec.describe Book::Copy::Create, type: :operation do
  let(:result) { Book::Copy::Create.(params, dependencies) }

  let(:params) { {book_id: book_id} }

  let(:book_id) { book.id }

  let(:book) { Factory::Book.create }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { Factory::User.create }

  it 'successfully finds the book and creates a copy' do
    expect(result).to be_success
    expect(result['book']).to eq(book)
    expect(result['model']).to be_persisted
    expect(result['model'].book).to eq(book)
    expect(result['model'].owner).to eq(current_user)
  end

  context 'with invalid book id' do
    let(:book_id) { [0, :invalid].sample }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'without current user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end

  context 'with already existing copy' do
    let!(:copy) { Book::Copy::Create.(params, dependencies)['model'] }

    it 'successfully finds the book and the exisiting copy' do
      expect(result).to be_success
      expect(result['book']).to eq(book)
      expect(result['model']).to eq(copy)
    end
  end
end
