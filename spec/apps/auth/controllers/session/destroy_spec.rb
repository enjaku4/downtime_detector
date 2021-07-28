require_relative '../../../shared/controllers/authentication'

RSpec.describe Auth::Controllers::Session::Destroy do
  it_behaves_like 'user authentication'

  subject { action.call('rack.session' => { user_id: Fabricate(:user).id }) }

  let(:action) { described_class.new }

  it 'signs user out' do
    expect(action).to receive(:sign_out)
    subject
  end

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to auth root path' do
    expect(subject[1]['location']).to eq(Auth.routes.root_path)
  end
end