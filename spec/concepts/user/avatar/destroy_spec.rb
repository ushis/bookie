require 'rails_helper'

RSpec.describe User::Avatar::Destroy, type: :operation do
  let(:result) { User::Avatar::Destroy.(nil, dependencies) }

  let(:dependencies) { {avatar: avatar} }

  let(:avatar) { user.avatar }

  let(:user) { Factory::User.create }

  it 'successfully destroy the avatar and its images' do
    expect(result).to be_success
    expect { avatar.reload }.to raise_error(ActiveRecord::RecordNotFound)

    User::Avatar::Proxy::Default.new(avatar).tap do |proxy|
      expect { proxy.image[:original].fetch.apply }.to \
        raise_error(Dragonfly::Job::Fetch::NotFound)

      expect { proxy.image[:large].fetch.apply }.to \
        raise_error(Dragonfly::Job::Fetch::NotFound)

      expect { proxy.image[:small].fetch.apply }.to \
        raise_error(Dragonfly::Job::Fetch::NotFound)

      expect { proxy.image[:tiny].fetch.apply }.to \
        raise_error(Dragonfly::Job::Fetch::NotFound)
    end
  end
end
