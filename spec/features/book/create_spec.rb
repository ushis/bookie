require 'rails_helper'

RSpec.describe 'Create book', type: :feature do
  before { user_factory.create }

  before { sign_in(user_factory.username, user_factory.password) }

  let(:user_factory) { Factory::User.new }

  before { NetStub::GoogleBooks.stub_request(isbn, []) }

  before { NetStub::WorldCat.stub_request(isbn, []) }

  before { NetStub::OpenLibrary.stub_request(isbn, nil) }

  before { NetStub::BigBookSearch.stub_request(isbn, []) }

  before { visit('/') }

  let(:isbn) { Factory::Book.isbn }

  let(:title) { Factory::Book.title }

  let(:authors) { Factory::Book.authors }

  let(:cover_url) { Faker::Internet.url }

  it 'is possible to create a book' do
    # check navigation and navigate to sign in page
    expect(page).to have_selector('nav.navbar')

    within('nav.navbar') do
      click_link('Add book')
    end

    # check and fill form
    expect(page).to have_selector('form.new_book')

    within('form.new_book') do
      fill_in('ISBN', with: isbn)
      click_button('Lookup')
    end

    # check and fill form
    expect(page).to have_selector('form.new_book')

    within('form.new_book') do
      fill_in('ISBN', with: isbn)
      fill_in('Authors', with: authors)
      click_button('Save book')
    end

    # check and fill form
    expect(page).to have_selector('form.new_book')

    within('form.new_book') do
      expect(page).to have_selector('.book_title.has-error')

      fill_in('Title', with: title)
      click_button('Save book')
    end

    # check page
    expect(page).to have_selector('h1', text: title)
  end
end
