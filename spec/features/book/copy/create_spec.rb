require 'rails_helper'

RSpec.describe 'Create copy', type: :feature do
  let!(:book) { Factory::Book.create }

  let!(:user) { user_factory.create }

  let(:user_factory) { Factory::User.new }

  before { Bookie::Search.client.indices.refresh(index: 'books') }

  before { sign_in(user_factory.username, user_factory.password) }

  before { visit('/') }

  it 'is possible to create a copy' do
    # check navigation and search for isbn
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      fill_in('q', with: book.isbn)
      click_button(class: 'button')
    end

    # check and click link to book
    expect(page).to have_link(book.title)
    click_link(book.title)

    # check and click button to create copy
    expect(page).to have_button('I have this book')
    click_button('I have this book')

    # check page
    expect(page).to have_selector('h1', text: book.title)
    expect(page).to_not have_button('I have this book')
  end
end
