require_relative '../../../shared/controllers/authentication'

RSpec.describe Web::Controllers::User::DeleteEmail do
  it_behaves_like 'user authentication'

  subject { action.call('rack.session' => { user_id: user.id }) }

  let(:action) { described_class.new }
  let(:email) { Faker::Internet.email }
  let(:user) { Fabricate(:user, email: email) }

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to web root path' do
    expect(subject[1]['location']).to eq(Web.routes.root_path)
  end

  it "deletes user\'s email" do
    expect { subject }.to change { UserRepository.new.find(user.id).email }.from(email).to(nil)
  end
end