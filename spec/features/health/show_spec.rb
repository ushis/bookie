require 'rails_helper'

RSpec.describe 'Show health', type: :feature do
  before { visit('/health') }

  it 'is possible to fetch the systems health' do
    expect(JSON.parse(page.text).fetch('status')).to match(/\Aok|critical\z/)
  end
end
