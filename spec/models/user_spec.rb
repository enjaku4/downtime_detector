require 'rails_helper'

describe User, type: :model do
  describe '.with_email' do
    before { create(:user) }

    context 'if a user with an email exists' do
      let(:user) { create(:user, email: 'foo@bar.baz') }

      it 'returns only the users having an email address' do
        expect(described_class.with_email).to contain_exactly(user)
      end
    end

    context 'if there is no user with an email' do
      it 'returns an empty relation' do
        expect(described_class.with_email).to be_empty
      end
    end
  end
end
