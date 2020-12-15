require 'rails_helper'

describe Users::Emails::DeletionInteraction do
  subject { described_class.run(user: user) }

  let(:user) { create(:user, email: 'foo@bar.baz') }

  describe '#execute' do
    it "resets the user\'s email" do
      expect { subject }.to change { user.email }.to(nil)
    end
  end
end
