require 'rails_helper'

describe WebAddresses::CreationInteraction do
  subject { described_class.run(url: url, user: user) }

  let(:user) { create(:user) }

  describe '#execute' do
    context 'if the url is blank' do
      let(:url) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
      end

      it 'has the url blank error' do
        expect(subject.errors.details[:url]).to include({ error: :blank })
      end
    end

    context 'if the url is not blank' do
      context 'if the url is not actually a url' do
        let(:url) { 'foo' }

        it 'is invalid' do
          expect(subject).to be_invalid
        end

        it 'has the url invalid error' do
          expect(subject.errors.details[:url]).to include({ error: :invalid, value: 'foo' })
        end
      end

      context 'if a web address with such a url exists' do
        let(:web_address) { create(:web_address) }
        let(:url) { web_address.url }

        context 'if the web address is linked with the user' do
          before { user.web_addresses << web_address }

          it 'is invalid' do
            expect(subject).to be_invalid
          end

          it 'has the url exists error' do
            expect(subject.errors.details[:url]).to include({ error: :exists })
          end

          it 'does not create a new web address' do
            expect { subject }.not_to change { WebAddress.where(url: url, status: :unknown).count }.from(1)
          end

          it 'does nothing with the existing link between the web address and the user' do
            expect { subject }.not_to change { user.web_addresses.exists?(web_address.id) }.from(true)
          end
        end

        context 'if the web address is not linked with the user' do
          it 'is valid' do
            expect(subject).to be_valid
          end

          it 'does not create a new web address' do
            expect { subject }.not_to change { WebAddress.where(url: url, status: :unknown).count }.from(1)
          end

          it 'links the existing web address with the user' do
            expect { subject }.to change { user.web_addresses.exists?(web_address.id) }.from(false).to(true)
          end
        end
      end

      context 'if a web address with such a url does not exist' do
        let(:url) { 'https://yahoo.com' }

        it 'is valid' do
          expect(subject).to be_valid
        end

        it 'creates a new web address' do
          expect { subject }.to change { WebAddress.where(url: url, status: :unknown).count }.from(0).to(1)
        end

        it 'links the newly created web address with the user' do
          expect { subject }.to change { user.web_addresses.where(url: url, status: :unknown).count }.from(0).to(1)
        end
      end
    end
  end
end
