shared_examples_for 'user authentication' do
  subject { action.call({}) }

  let(:action) { described_class.new }

  it 'redirects' do
    expect(subject[0]).to eq(302)
  end

  it 'redirects to root path' do
    expect(subject[1]['location']).to eq(Web.routes.root_path)
  end

  it 'shows flash message' do
    subject
    expect(action.exposures[:flash][:warning]).to eq('you have to sign in to your account first')
  end
end