require 'rails_helper'

RSpec.describe Book::Copy::Destroy, type: :operation do
  let(:result) { Book::Copy::Destroy.(params, dependencies) }

  let(:params) { {book_id: book_id } }

  let(:book_id) { book.id }

  let(:book) { Factory::Book.create }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { Factory::User.create }

  let!(:copy) { Book::Copy::Create.(params, dependencies)['model'] }

  it 'successfully finds the book and destroys the copy' do
    expect(result).to be_success
    expect(result['book']).to eq(book)
    expect { copy.reload }.to raise_error(ActiveRecord::RecordNotFound)
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

  context 'with already destroyed copy' do
    before { Book::Copy::Destroy.(params, dependencies) }

    it 'successfully finds the book and does nothing' do
      expect(result).to be_success
      expect(result['book']).to eq(book)
    end
  end
end
