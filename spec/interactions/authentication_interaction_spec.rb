require 'rails_helper'

describe AuthenticationInteraction do
  subject { described_class.run(nickname: nickname, password: password) }

  describe '#execute' do
    context 'if the nickname is absent' do
      let(:nickname) { '' }
      let(:password) { 'password' }

      it 'has the nickname blank error' do
        expect(subject.errors.details[:nickname]).to include({ error: :blank })
      end
    end

    context 'if the password is absent' do
      let(:nickname) { 'nickname' }
      let(:password) { '' }

      it 'has the password blank error' do
        expect(subject.errors.details[:password]).to include({ error: :blank })
      end
    end

    context "if the nickname\'s length is less than 6 symbols" do
      let(:nickname) { 'foo' }
      let(:password) { 'password' }

      it 'has the nickname too short error' do
        expect(subject.errors.details[:nickname]).to include({ count: 6, error: :too_short })
      end
    end

    context "if the password\'s length is less than 6 symbols" do
      let(:nickname) { 'nickname' }
      let(:password) { 'foo' }

      it 'has the password too short error' do
        expect(subject.errors.details[:password]).to include({ count: 6, error: :too_short })
      end
    end

    context 'if the user has already existed' do
      let(:user) { create(:user) }
      let(:nickname) { user.nickname }
      let(:password) { 'password' }

      it 'runs Users::VerificationInteraction' do
        expect(Users::VerificationInteraction).to receive(:run)
          .with(user: user, password: password).and_call_original
        subject
      end
    end

    context 'if there is no such user yet' do
      let(:nickname) { 'nickname' }
      let(:password) { 'password' }

      it 'runs Users::VerificationInteraction' do
        expect(Users::CreationInteraction).to receive(:run)
          .with(nickname: nickname, password: password).and_call_original
        subject
      end
    end
  end
end
