require_relative '../../../shared/controllers/authentication'

RSpec.describe Web::Controllers::User::UpdateEmail do
  it_behaves_like 'user authentication'

  subject { action.call('rack.session' => { user_id: user.id }, user: { email: email }) }

  let(:action) { described_class.new }
  let(:email) { Faker::Internet.email }
  let(:user) { Fabricate(:user) }
  let(:interactor) { instance_double(Users::UpdateEmail) }

  before { allow(Users::UpdateEmail).to receive(:new).with(user: user, email: email).and_return(interactor) }

  shared_examples_for 'redirection to root path' do
    it 'redirects' do
      expect(subject[0]).to eq(302)
    end

    it 'redirects to web root path' do
      expect(subject[1]['location']).to eq(Web.routes.root_path)
    end
  end

  context 'if interaction is successful' do
    before do
      interactor_result = Hanami::Interactor::Result.new
      allow(interactor).to receive(:call).and_return(interactor_result)
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

    it 'shows flash message' do
      subject
      expect(action.exposures[:flash][:danger]).to eq('foo')
    end

    it_behaves_like 'redirection to root path'
  end
end