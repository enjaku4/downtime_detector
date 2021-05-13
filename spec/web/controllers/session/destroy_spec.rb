require_relative '../../../../apps/web/controllers/session/destroy'

RSpec.describe Web::Controllers::Session::Destroy do
  subject { action.call({ 'rack.session' => { user_id: Fabricate(:user).id } }) }

  let(:action) { described_class.new }

  it 'authenticates user' do
    expect(action).to receive(:authenticate_user)
    subject
  end

  it 'signs user out' do
    expect(action).to receive(:sign_out)
    subject
  end

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to root path' do
    expect(subject[1]['location']).to eq(Web.routes.root_path)
  end
end