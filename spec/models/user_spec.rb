require 'rails_helper'

describe User, type: :model do
  describe '.with_email' do
    let(:user) { create(:user, email: 'foo@bar.baz') }

    before { create(:user) }

    it 'returns only the users having an email address' do
      expect(User.with_email).to contain_exactly(user)
    end
  end
end
