RSpec.describe User do
  describe '#password_correct?' do
    subject { user.password_correct?(password) }

    let(:password) { Faker::Internet.password }

    context 'if passwords match' do
      let(:user) { Fabricate.build(:user, password: BCrypt::Password.create(password)) }

      it { is_expected.to be true }
    end

    context 'if passwords do not match' do
      let(:user) { Fabricate.build(:user, password: BCrypt::Password.create(Faker::Internet.password)) }

      it { is_expected.to be false }
    end
  end
end