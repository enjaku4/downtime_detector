require 'rails_helper'

describe Users::Emails::UpdateInteraction do
  subject { described_class.run(user: user, email: email) }

  let(:user) { create(:user) }

  describe '#execute' do
    context 'if the email is absent' do
      let(:email) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
      end

      it 'has the email blank error' do
        expect(subject.errors.details[:email]).to include({ error: :blank })
      end
    end

    context 'if the email is not actually an email' do
      let(:email) { 'foo' }

      it 'is invalid' do
        expect(subject).to be_invalid
      end

      it 'has the email blank error' do
        expect(subject.errors.details[:email]).to include({ error: :invalid, value: 'foo' })
      end
    end

    context 'if the email is present and valid' do
      let(:email) { 'foo@bar.baz' }

      it 'is valid' do
        expect(subject).to be_valid
      end

      it "updates the user\'s email" do
        expect { subject }.to change { user.email }.to(email)
      end
    end
  end
end
