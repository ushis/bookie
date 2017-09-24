require 'rails_helper'

RSpec.describe 'Show health', type: :feature do
  before { visit('/health') }

  it 'is possible to fetch the systems health' do
    expect(response_headers['Content-Type']).to \
      eq('application/json; charset=utf-8')

    expect(JSON.parse(body).fetch('status')).to \
      match(/\Aok|critical\z/)
  end
end
