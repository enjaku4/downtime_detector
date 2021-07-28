require_relative '../shared/recaptcha_validation'

RSpec.describe Web::Controllers::Session::Create do
  it_behaves_like 'recaptcha validation', 'sign_in/sign_up', Web.routes.root_path

  subject { action.call({ 'g-recaptcha-response-data' => { 'sign_in/sign_up' => 'foo' }, session: session_params }) }

  let(:action) { described_class.new }
  let(:session_params) { Hash[nickname: 'foo', password: 'bar'] }
  let(:interactor) { instance_double(Auth::AuthenticateUser) }

  before { allow(Auth::AuthenticateUser).to receive(:new).with(session_params).and_return(interactor) }

  shared_examples_for 'redirection to root path' do
    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to root path' do
      expect(subject[1]['location']).to eq(Web.routes.root_path)
    end
  end

  context 'if interaction is successful' do
    let(:user) { Fabricate.build(:user) }

    before do
      interactor_result = Hanami::Interactor::Result.new(user: user)
      allow(interactor).to receive(:call).and_return(interactor_result)
    end

    it 'signs user in' do
      expect(action).to receive(:sign_in).with(user)
      subject
    end

    it 'does not show any flash messages' do
      subject
      expect(action.exposures[:flash].empty?).to be true
    end

    it_behaves_like 'redirection to root path'
  end

  context 'if interaction is unsucsessful' do
    before do
      interactor_result = Hanami::Interactor::Result.new
      interactor_result.add_error('foo')
      allow(interactor).to receive(:call).and_return(interactor_result)
    end

    it 'doesn not sign user in' do
      expect(action).not_to receive(:sign_in)
      subject
    end

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:danger]).to eq('foo')
    end

    it_behaves_like 'redirection to root path'
  end
end