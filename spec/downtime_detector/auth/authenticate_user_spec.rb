RSpec.describe Auth::AuthenticateUser do
  subject { described_class.new(args).call }

  context 'if validation is unsuccessful' do
    let(:args) { { nickname: 'foo', password: 'bar' } }

    it 'is unsuccessful' do
      expect(subject.successful?).to be false
    end

    it 'has errors' do
      expect(subject.errors).to contain_exactly('password size cannot be less than 6')
    end

    it 'does not return user' do
      expect(subject.user).to be_nil
    end

    it 'does not create any users' do
      expect { subject }.not_to change { UserRepository.new.last }.from(nil)
    end
  end

  context 'if validation is successful' do
    context 'if user exists' do
      let!(:user) { Fabricate(:user) }

      context 'if password is correct' do
        let(:args) { { nickname: 'foobar', password: 'password' } }

        it 'is successful' do
          expect(subject.successful?).to be(true)
        end

        it 'returns the user' do
          expect(subject.user).to eq(user)
        end
      end

      context 'if password is incorrenct' do
        let(:args) { { nickname: 'foobar', password: 'barbaz' } }

        it 'is unsuccessful' do
          expect(subject.successful?).to be(false)
        end

        it 'has errors' do
          expect(subject.errors).to contain_exactly('password is incorrect')
        end
      end
    end

    context 'if user does not exist' do
      let(:args) { { nickname: 'barbaz', password: 'bazbad' } }
      let(:user_repository) { UserRepository.new }
      let(:user_double) { double }

      before do
        allow(BCrypt::Password).to receive(:create).with('bazbad').and_return('password_hash')
        allow(UserRepository).to receive(:new).and_return(user_repository)
        allow(user_repository).to receive(:create).with(nickname: 'barbaz', password: 'password_hash').and_return(user_double)
      end

      it 'is successful' do
        expect(subject.successful?).to be(true)
      end

      it 'is creates a new user' do
        expect(user_repository).to receive(:create).with(nickname: 'barbaz', password: 'password_hash')
        subject
      end

      it 'returns created user' do
        expect(subject.user).to be user_double
      end
    end
  end
end