require 'rails_helper'

RSpec.describe 'Lookup book', type: :feature do
  before { user_factory.create }

  before { sign_in(user_factory.username, user_factory.password) }

  let(:user_factory) { Factory::User.new }

  before {
    NetStub::GoogleBooks.stub_request(isbn, {
      isbn: isbn,
      title: title,
      authors: authors,
    })
  }

  before { NetStub::BigBookSearch.stub_request(isbn, cover_url) }

  before { NetStub::Image.stub_request(cover_url) }

  before { visit('/') }

  let(:isbn) { Factory::Book.isbn }

  let(:title) { Factory::Book.title }

  let(:authors) { Factory::Book.authors }

  let(:cover_url) { Faker::Internet.url }

  it 'is possible to lookup a book' do
    # check navigation and navigate to sign in page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Add book')
    end

    # check and fill form
    expect(page).to have_selector('form.new_book')

    within('form.new_book') do
      fill_in('ISBN', with: 'invalid')
      click_button('Lookup')
    end

    # check and fill form
    expect(page).to have_selector('form.new_book')

    within('form.new_book') do
      expect(page).to have_selector('#book_isbn.is-danger')

      fill_in('ISBN', with: isbn)
      click_button('Lookup')
    end

    # check page
    expect(page).to have_selector('h1', text: title)
  end
end
