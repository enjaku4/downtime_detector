RSpec.describe Web::Interactors::AuthenticateUser do
  subject { described_class.new(args).call }

  context 'if validation is unsuccessful' do
    let(:args) { { nickname: 'foo', password: 'bar' } }

    it 'is unsuccessful' do
      expect(subject.successful?).to be false
    end

    it 'has errors' do
      expect(subject.errors).to eq ['nickname size cannot be less than 6, password size cannot be less than 6']
    end

    it 'does not return user' do
      expect(subject.user).to be_nil
    end

    it 'does not create any users' do
      subject
      expect(UserRepository.new.last).to be_nil
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
        let(:args) { { nickname: 'foobar', password: 'barbazbad' } }

        it 'is unsuccessful' do
          expect(subject.successful?).to be(false)
        end

        it 'has errors' do
          expect(subject.errors).to eq(['password is incorrect'])
        end
      end
    end

    context 'if user does not exist' do
      let(:args) { { nickname: 'barbaz', password: 'bazbad' } }

      it 'is successful' do
        expect(subject.successful?).to be(true)
      end

      it 'is creates a new user' do
        expect(User).to receive(:create).with(args)
        subject
      end

      it 'returns created user' do
        expect(subject.user.nickname).to eq('barbaz')
        expect(subject.user.password_correct?('bazbad')).to be true
      end
    end
  end
end