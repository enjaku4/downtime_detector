shared_examples_for "the processing of the web address pinging result with \'faulty\' status" do
  let(:time_now) { Time.parse('27.01.2020 00:13') }

  before do
    allow(Time).to receive(:now).and_return(time_now)
    allow(PingingService::UsersNotificationWorker).to receive(:perform_async).with(web_address.id)
  end

  it "updates the web address\'s ping time" do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).pinged_at }.to(time_now)
  end

  context 'if the notifications_sent flag was true' do
    before { WebAddressRepository.new.update(web_address.id, notifications_sent: true) }

    it 'does not change the notifications_sent flag' do
      expect { subject }.not_to change { WebAddressRepository.new.find(web_address.id).notifications_sent }.from(true)
    end
  end

  context 'if the notifications_sent flag was false' do
    before { WebAddressRepository.new.update(web_address.id, notifications_sent: false) }

    it 'changes the notifications_sent flag' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).notifications_sent }.from(false).to(true)
    end
  end

  it 'sends notifications' do
    subject
    expect(PingingService::UsersNotificationWorker).to have_received(:perform_async).with(web_address.id)
  end
end

shared_examples_for "the processing of the web address pinging result with \'up\' status" do
  let(:time_now) { Time.parse('27.01.2020 00:13') }

  before { allow(Time).to receive(:now).and_return(time_now) }

  it "updates the web address\'s ping time" do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).pinged_at }.to(time_now)
  end

  context 'if the notifications_sent flag was true' do
    before { WebAddressRepository.new.update(web_address.id, notifications_sent: true) }

    it 'changes the notifications_sent flag' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).notifications_sent }.from(true).to(false)
    end
  end

  context 'if the notifications_sent flag was false' do
    before { WebAddressRepository.new.update(web_address.id, notifications_sent: false) }

    it 'does not change the notifications_sent flag' do
      expect { subject }.not_to change { WebAddressRepository.new.find(web_address.id).notifications_sent }.from(false)
    end
  end

  it 'does not send notifications' do
    expect(PingingService::UsersNotificationWorker).not_to receive(:perform_async)
    subject
  end
end