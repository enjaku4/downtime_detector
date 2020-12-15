require 'rails_helper'

shared_examples_for "the processing of the web address pinging result with \'faulty\' status" do
  it "updates the web address\'s ping time" do
    expect(web_address).to receive(:update_ping_time!)
    subject
  end

  context 'if the notification_sent flag was true' do
    before { web_address.notification_sent = true }

    it 'does not change the notification_sent flag' do
      expect { subject }.not_to change { web_address.notification_sent }.from(true)
    end
  end

  context 'if the notification_sent flag was false' do
    before { web_address.notification_sent = false }

    it 'changes the notification_sent flag' do
      expect { subject }.to change { web_address.notification_sent }.from(false).to(true)
    end
  end

  it 'deletes old problems' do
    expect(web_address).to receive(:delete_old_problems!)
    subject
  end

  it 'sends notifications' do
    expect(web_address).to receive(:notify_users)
    subject
  end
end

shared_examples_for "the processing of the web address pinging result with \'up\' status" do
  it "updates the web address\'s ping time" do
    expect(web_address).to receive(:update_ping_time!)
    subject
  end

  context 'if the notification_sent flag was true' do
    before { web_address.notification_sent = true }

    it 'changes the notification_sent flag' do
      expect { subject }.to change { web_address.notification_sent }.from(true).to(false)
    end
  end

  context 'if the notification_sent flag was false' do
    before { web_address.notification_sent = false }

    it 'does not change the notification_sent flag' do
      expect { subject }.not_to change { web_address.notification_sent }.from(false)
    end
  end

  it 'does not delete old problems' do
    expect(web_address).not_to receive(:delete_old_problems!)
    subject
  end

  it 'does not send notifications' do
    expect(web_address).not_to receive(:notify_users)
    subject
  end

  it 'does not create any problems' do
    expect { subject }.not_to change { Problem.count }.from(0)
  end
end
