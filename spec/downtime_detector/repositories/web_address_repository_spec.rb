RSpec.describe WebAddressRepository do
  describe '#find_or_create_by_url' do
    subject { repo_instance.find_or_create_by_url(url) }

    let(:url) { Faker::Internet.url }
    let(:repo_instance) { described_class.new }

    context 'if there is a record with such url' do
      let!(:web_address) { Fabricate(:web_address, url: url) }

      it { is_expected.to eq web_address }
    end

    context 'if there are no records with such url' do
      let(:web_address) { double }

      before { allow(repo_instance).to receive(:create).with(url: url).and_return(web_address) }

      it 'creates a new web address' do
        subject
        expect(repo_instance).to have_received(:create)
      end

      it { is_expected.to eq web_address }
    end
  end

  describe '#belonging_to_user' do
    subject { described_class.new.belonging_to_user(user.id) }

    let(:user) { Fabricate(:user) }
    let(:web_addresses) { Fabricate.times(2, :web_address) }

    before do
      web_addresses.each do |web_address|
        Fabricate(:user_having_web_address, user_id: user.id, web_address_id: web_address.id)
      end
      Fabricate.times(2, :web_address)
    end

    it { is_expected.to match_array(web_addresses) }
  end

  describe '#orphaned?' do
    subject { described_class.new.orphaned?(web_address.id) }

    let(:web_address) { Fabricate(:web_address) }

    context 'if it is associated with a user' do
      before { Fabricate(:user_having_web_address, user_id: Fabricate(:user).id, web_address_id: web_address.id) }

      it { is_expected.to be false }
    end

    context 'if it is not associated with any user' do
      it { is_expected.to be true }
    end
  end

  describe '#ready_to_ping' do
    let!(:web_address_pinged_recently) { Fabricate(:web_address, pinged_at: Chronic.parse('6 minutes ago')) }
    let!(:web_address_not_pinged) { Fabricate(:web_address, pinged_at: nil) }

    before do
      Fabricate(:web_address, pinged_at: Chronic.parse('1 minute ago'))
      Fabricate(:web_address, pinged_at: Chronic.parse('4 minutes ago'))
    end

    it 'returns only ready to ping web addresses' do
      expect(described_class.new.ready_to_ping)
        .to contain_exactly(web_address_pinged_recently, web_address_not_pinged)
    end
  end

  describe '#find_with_users' do
    subject { described_class.new.find_with_users(web_address.id) }

    let(:web_address) { Fabricate(:web_address) }
    let(:users) { Fabricate.times(2, :user) }

    before do
      users.each do |user|
        UserHavingWebAddressRepository.new.create(user_id: user.id, web_address_id: web_address.id)
      end
      Fabricate(:user)
    end

    it { is_expected.to eq(web_address) }

    it 'loads users associated with the web address' do
      expect(subject.users).to match_array(users)
    end
  end
end
