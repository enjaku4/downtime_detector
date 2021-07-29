RSpec.describe WebAddressRepository do
  describe '#find_or_create_by_url' do
    subject { repo_instance.find_or_create_by_url(url) }

    let(:url) { 'https://google.com' }
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
        expect(repo_instance).to have_received(:create).with(url: url)
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
end
