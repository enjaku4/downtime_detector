require 'rails_helper'

describe Users::CreationInteraction do
  subject { described_class.run(nickname: 'foobar', password: 'a_password') }

  describe '#execute' do
    before do
      allow(BCrypt::Engine).to receive(:generate_salt).and_return('$2a$12$st7h6K2HF6RqVZOvlLu7qe')
    end

    it 'creates a new user with proper attributes' do
      expect { subject }.to change {
        User.where(
          nickname: 'foobar',
          password_salt: '$2a$12$st7h6K2HF6RqVZOvlLu7qe',
          password_hash: '$2a$12$st7h6K2HF6RqVZOvlLu7qeoSDMSK7sWEoFCXMVIgCTU7.5XjyGdku'
        ).count
      }.from(0).to(1)
    end
  end
end
