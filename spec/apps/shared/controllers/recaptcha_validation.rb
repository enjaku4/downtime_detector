shared_examples_for 'recaptcha validation' do |recaptcha_action, redirect_path|
  subject do
    action.call(
      'g-recaptcha-response-data' => { recaptcha_action => 'foo' },
      'rack.session' => { user_id: Fabricate(:user).id }
    )
  end

  let(:action) { described_class.new }

  before do
    allow(action).to receive(:verify_recaptcha).with(
      action: recaptcha_action,
      minimum_score: 0.6,
      response: 'foo',
      skip_remote_ip: true,
      env: 'test'
    ).and_return(false)
  end

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to redirect path' do
    expect(subject[1]['location']).to eq(redirect_path)
  end

  it 'shows flash message' do
    subject
    expect(action.exposures[:flash][:danger]).to eq('recaptcha is invalid')
  end
end