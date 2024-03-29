RSpec.describe Auth::AuthenticateUser do
  subject { described_class.new(**args, user_repository: user_repository).call }

  let(:args) { Hash[nickname: Faker::Internet.username, password: Faker::Internet.password] }
  let(:validator) { instance_double(Auth::UserValidator) }
  let(:user_repository) { UserRepository.new }

  before { allow(Auth::UserValidator).to receive(:new).with(args).and_return(validator) }

  context 'if validation is unsuccessful' do
    before do
      allow(validator).to receive(:validate).and_return(
        double(:success? => false, errors: { nickname: [:bad], password: [:baz] })
      )
    end

    it { is_expected.not_to be_successful }

    it 'has errors' do
      expect(subject.errors).to contain_exactly('bad, baz')
    end

    it 'does not return user' do
      expect(subject.user).to be_nil
    end

    it 'does not create any users' do
      expect { subject }.not_to change { UserRepository.new.last }.from(nil)
    end
  end

  context 'if validation is successful' do
    before do
      allow(validator).to receive(:validate).and_return(
        double(:success? => true, output: args)
      )
    end

    context 'if user exists' do
      context 'if password is correct' do
        let!(:user) { Fabricate(:user, nickname: args[:nickname], password: BCrypt::Password.create(args[:password])) }

        it { is_expected.to be_successful }

        it 'returns the user' do
          expect(subject.user).to eq(user)
        end
      end

      context 'if password is incorrect' do
        let!(:user) { Fabricate(:user, nickname: args[:nickname], password: BCrypt::Password.create(Faker::Internet.password)) }

        it { is_expected.not_to be_successful }

        it 'has errors' do
          expect(subject.errors).to contain_exactly('password is incorrect')
        end
      end
    end

    context 'if user does not exist' do
      let(:user_double) { double }
      let(:password_hash) { BCrypt::Password.create(args[:password]) }

      before do
        allow(BCrypt::Password).to receive(:create).with(args[:password]).and_return(password_hash)
        allow(user_repository).to receive(:create).with(nickname: args[:nickname], password: password_hash).and_return(user_double)
      end

      it { is_expected.to be_successful }

      it 'is creates a new user' do
        subject
        expect(user_repository).to have_received(:create)
      end

      it 'returns created user' do
        expect(subject.user).to be user_double
      end
    end
  end
end