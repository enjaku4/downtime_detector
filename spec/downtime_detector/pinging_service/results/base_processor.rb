shared_examples_for 'pinging result processor' do |status_code, status, message|
  let(:time_now) { Time.parse('27.01.2020 00:13') }

  before { allow(Time).to receive(:now).and_return(time_now) }

  it "updates the web address\'s ping time" do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).pinged_at }.to(time_now)
  end

  it 'updates the message' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).message }.to(message)
  end

  it 'changes the http_status_code attribute' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.to(status_code)
  end

  it 'changes the status attribute' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.to(status)
  end
end
