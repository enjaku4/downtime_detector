RSpec.describe User, type: :entity do
  describe '.create' do
    subject { described_class.create(nickname: nickname, password: 'password') }

    let(:repository) { UserRepository.new }
    let(:nickname) { 'foobar' }
    let(:password_salt) { '$2a$12$PXGKAGZu.Gq0wCzUdP44tu' }
    let(:password_hash) { '$2a$12$PXGKAGZu.Gq0wCzUdP44tugTCLEOIMxpVcDEIywfDFQ3SRdTc5Vj6' }
    let(:user_attributes) { { nickname: nickname, password_salt: password_salt, password_hash: password_hash } }

    before do
      allow(BCrypt::Engine).to receive(:generate_salt).and_return(password_salt)
      allow(UserRepository).to receive(:new).and_return(repository)
    end

    it { is_expected.to be_a User }

    it { is_expected.to have_attributes(user_attributes) }

    it 'is persisted' do
      expect(repository).to receive(:create).with(user_attributes)
      subject
    end
  end
end