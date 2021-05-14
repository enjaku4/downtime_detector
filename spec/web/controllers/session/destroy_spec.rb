require_relative '../shared/authentication'

RSpec.describe Web::Controllers::Session::Destroy do
  it_behaves_like 'user authentication'

  subject { action.call({ 'rack.session' => { user_id: Fabricate(:user).id } }) }

  let(:action) { described_class.new }

  it 'signs user out' do
    subject
    expect(action.exposures[:session][:user_id]).to be_nil
  end

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to root path' do
    expect(subject[1]['location']).to eq(Web.routes.root_path)
  end
end