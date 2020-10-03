require 'rails_helper'

describe Users::VerificationInteraction do
  subject { described_class.run(user: user, password: password) }

  let(:user) { create(:user) }

  describe '#execute' do
    context 'if the password is correct' do
      let(:password) { 'password' }

      it 'is valid' do
        expect(subject).to be_valid
      end

      it 'returns the user' do
        expect(subject.result).to be(user)
      end
    end

    context 'if the password is incorrect' do
      let(:password) { 'wrong_password' }

      it 'is invalid' do
        expect(subject).to be_invalid
      end

      it 'has the password incorrect error' do
        expect(subject.errors.details[:password]).to include({ error: :incorrect })
      end
    end
  end
end
