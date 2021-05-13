require_relative '../../../../apps/web/controllers/session/create'

RSpec.describe Web::Controllers::Session::Create do
  subject { action.call({ 'g-recaptcha-response-data' => { 'sign_in/sign_up' => 'foo' }, session: session_params }) }

  let(:action) { described_class.new }
  let(:session_params) { { nickname: 'foo', password: 'bar' } }
  let(:interactor_double) { Web::Interactors::AuthenticateUser.new(session_params) }

  before { allow(Web::Interactors::AuthenticateUser).to receive(:new).with(session_params).and_return(interactor_double) }

  shared_examples_for 'recaptcha validation and redirection to root path' do
    it 'validates recaptcha' do
      expect(action).to receive(:validate_recaptcha).with(action: 'sign_in/sign_up')
      subject
    end

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
      allow(interactor_double).to receive(:call).and_return(interactor_result)
    end

    it 'signs user in' do
      subject
      expect(action.exposures[:session][:user_id]).to eq(user.id)
    end

    it 'does not show any flash messages' do
      subject
      flash = action.exposures[:flash]
      expect(action.exposures[:flash].empty?).to be true
    end

    it_behaves_like 'recaptcha validation and redirection to root path'
  end

  context 'if interaction is unsucsessful' do
    before do
      interactor_result = Hanami::Interactor::Result.new
      interactor_result.add_error('foo')
      allow(interactor_double).to receive(:call).and_return(interactor_result)
    end

    it 'doesn not sign user in' do
      subject
      expect(action.exposures[:session][:user_id]).to be_nil
    end

    it 'shows flash message' do
      subject
      flash = action.exposures[:flash]
      expect(action.exposures[:flash][:danger]).to eq('foo')
    end

    it_behaves_like 'recaptcha validation and redirection to root path'
  end
end