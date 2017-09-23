require 'rails_helper'

RSpec.describe Book::Index, type: :operation do
  let(:result) { Book::Index.() }

  let!(:books) { Array.new(3) { |_| Factory::Book.create } }

  it 'successfully fetches all books' do
    expect(result).to be_success
    expect(result['books']).to match_array(books)
  end
end
