RSpec.describe User do
  describe '#password_correct?' do
    subject { user.password_correct?('password') }

    context 'if passwords match' do
      let(:user) { Fabricate.build(:user) }

      it { is_expected.to be true }
    end

    context 'if passwords do not match' do
      let(:user) { Fabricate.build(:user, password: BCrypt::Password.create('foobar')) }

      it { is_expected.to be false }
    end
  end
end