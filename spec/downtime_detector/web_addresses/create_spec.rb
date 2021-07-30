RSpec.describe ::WebAddresses::Create do
  subject { described_class.new(url: url, user: user, web_address_repository: web_address_repository).call }

  let(:url) { Faker::Internet.url }
  let(:user) { Fabricate(:user) }
  let(:validator) { instance_double(WebAddresses::UrlValidator) }
  let(:web_address_repository) { WebAddressRepository.new }

  before { allow(WebAddresses::UrlValidator).to receive(:new).with(url: url).and_return(validator) }

  context 'if validation is unsuccessful' do
    before { allow(validator).to receive(:validate).and_return(double(:success? => false, errors: { url: [:foo] })) }

    it 'is unsuccessful' do
      expect(subject.successful?).to be false
    end

    it 'has errors' do
      expect(subject.errors).to contain_exactly('foo')
    end

    it 'does not create any web addresses' do
      expect { subject }.not_to change { web_address_repository.last }.from(nil)
    end

    it 'does not create any users having web addresses' do
      expect { subject }.not_to change { UserHavingWebAddressRepository.new.last }.from(nil)
    end
  end

  context 'if validation is successful' do
    before { allow(validator).to receive(:validate).and_return(double(:success? => true, output: { url: url })) }

    context 'if user has already had web address' do
      before { UserHavingWebAddressRepository.new.create(user_id: user.id, web_address_id: Fabricate(:web_address, url: url).id) }

      it 'has errors' do
        expect(subject.errors).to contain_exactly('URL already exists')
      end
    end

    context 'if user does not have web address' do
      context 'if web address exists' do
        let!(:web_address) { Fabricate(:web_address, url: url) }

        it 'creates an association' do
          expect { subject }
            .to change { UserHavingWebAddressRepository.new.exists?(user_id: user.id, web_address_id: web_address.id) }
            .from(false).to(true)
        end
      end

      context 'if web address does not exist' do
        let(:web_address) { Fabricate(:web_address, url: url) }

        before { allow(web_address_repository).to receive(:find_or_create_by_url).with(url).and_return(web_address) }

        it 'creates a web_address' do
          subject
          expect(web_address_repository).to have_received(:find_or_create_by_url).with(url)
        end

        it 'creates an association' do
          expect { subject }
            .to change { UserHavingWebAddressRepository.new.exists?(user_id: user.id, web_address_id: web_address.id) }
            .from(false).to(true)
        end
      end
    end
  end
end