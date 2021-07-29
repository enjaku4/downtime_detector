require_relative '../../../shared/controllers/authentication'
require_relative '../../../shared/controllers/recaptcha_validation'

RSpec.describe Web::Controllers::WebAddresses::Create do
  it_behaves_like 'user authentication'
  it_behaves_like 'recaptcha validation', 'create_web_address', Web.routes.new_web_address_path

  subject { action.call('rack.session' => { user_id: user.id }, web_address: { url: url }) }

  let(:action) { described_class.new }
  let(:user) { Fabricate(:user) }
  let(:url) { 'https://foo.bar' }
  let(:interactor) { instance_double(::WebAddresses::Create) }

  before { allow(::WebAddresses::Create).to receive(:new).with(url: url, user: user).and_return(interactor) }

  context 'if interaction is successful' do
    before do
      interactor_result = Hanami::Interactor::Result.new
      allow(interactor).to receive(:call).and_return(interactor_result)
    end

    it 'does not show any flash messages' do
      subject
      expect(action.exposures[:flash].empty?).to be true
    end

    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to web root path' do
      expect(subject[1]['location']).to eq(Web.routes.root_path)
    end
  end

  context 'if interaction is unsucsessful' do
    before do
      interactor_result = Hanami::Interactor::Result.new
      interactor_result.add_error('foo')
      allow(interactor).to receive(:call).and_return(interactor_result)
    end

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:danger]).to eq('foo')
    end

    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to web new web address path' do
      expect(subject[1]['location']).to eq(Web.routes.new_web_address_path)
    end
  end
end
