require 'rails_helper'

shared_examples_for "the processing of the web address pinging result with \'faulty\' status" do
  it "updates the web address\'s ping time" do
    expect(web_address).to receive(:update_ping_time!)
    subject
  end

  context 'if the notifications_sent flag was true' do
    before { web_address.notifications_sent = true }

    it 'does not change the notifications_sent flag' do
      expect { subject }.not_to change { web_address.notifications_sent }.from(true)
    end
  end

  context 'if the notifications_sent flag was false' do
    before { web_address.notifications_sent = false }

    it 'changes the notifications_sent flag' do
      expect { subject }.to change { web_address.notifications_sent }.from(false).to(true)
    end
  end

  it 'sends notifications' do
    expect { subject }.to enqueue_job(WebAddresses::UsersNotificationJob).once.with(web_address.id)
  end
end

shared_examples_for "the processing of the web address pinging result with \'up\' status" do
  it "updates the web address\'s ping time" do
    expect(web_address).to receive(:update_ping_time!)
    subject
  end

  context 'if the notifications_sent flag was true' do
    before { web_address.notifications_sent = true }

    it 'changes the notifications_sent flag' do
      expect { subject }.to change { web_address.notifications_sent }.from(true).to(false)
    end
  end

  context 'if the notifications_sent flag was false' do
    before { web_address.notifications_sent = false }

    it 'does not change the notifications_sent flag' do
      expect { subject }.not_to change { web_address.notifications_sent }.from(false)
    end
  end

  it 'does not send notifications' do
    expect { subject }.not_to enqueue_job(WebAddresses::UsersNotificationJob)
  end

  it 'does not create any problems' do
    expect { subject }.not_to change { Problem.count }.from(0)
  end
end
