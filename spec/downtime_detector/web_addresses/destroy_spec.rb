RSpec.describe ::WebAddresses::Destroy do
  subject { described_class.new(web_address: web_address, user: user).call }

  let(:web_address) { Fabricate(:web_address) }
  let(:user) { Fabricate(:user) }
  let!(:user_having_web_address) { Fabricate(:user_having_web_address, user_id: user.id, web_address_id: web_address.id) }

  it { is_expected.to be_successful }

  it 'deletes the association' do
    expect { subject }.to change { UserHavingWebAddressRepository.new.find(user_having_web_address.id) }
      .from(user_having_web_address).to(nil)
  end

  context 'if web address has become orphaned' do
    it 'deletes the web address' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id) }.from(web_address).to(nil)
    end
  end

  context 'if web address has not become orphaned' do
    before { UserHavingWebAddressRepository.new.create(user_id: Fabricate(:user).id, web_address_id: web_address.id) }

    it 'does not delete the web address' do
      expect { subject }.not_to change { WebAddressRepository.new.find(web_address.id) }.from(web_address)
    end
  end
end