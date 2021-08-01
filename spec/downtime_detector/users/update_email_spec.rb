RSpec.describe Users::UpdateEmail do
  subject { described_class.new(user: user, email: email).call }

  let(:user) { Fabricate(:user) }
  let(:email) { Faker::Internet.email }
  let(:validator) { instance_double(Users::EmailValidator) }

  before { allow(Users::EmailValidator).to receive(:new).with(email: email).and_return(validator) }

  context 'if validation is unsuccessful' do
    before { allow(validator).to receive(:validate).and_return(double(:success? => false, errors: { email: [:foo] })) }

    it { is_expected.not_to be_successful }

    it 'has errors' do
      expect(subject.errors).to contain_exactly('foo')
    end

    it "does not update user\'s email" do
      expect { subject }.not_to change { UserRepository.new.find(user.id).email }.from(nil)
    end
  end

  context 'if validation is successful' do
    before { allow(validator).to receive(:validate).and_return(double(:success? => true, output: { email: email })) }

    it { is_expected.to be_successful }

    it "updates user\'s email" do
      expect { subject }.to change { UserRepository.new.find(user.id).email }.from(nil).to(email)
    end
  end
end