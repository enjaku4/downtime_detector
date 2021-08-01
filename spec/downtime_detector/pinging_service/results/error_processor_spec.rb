require_relative 'base_processor'

describe PingingService::Results::ErrorProcessor do
  subject { described_class.new(web_address, exception: exception).call }

  let(:web_address) { Fabricate(:web_address, http_status_code: 200, status: 'up') }
  let(:exception) { Faraday::TimeoutError.new }

  it_behaves_like "the processing of the web address pinging result with \'faulty\' status"

  it 'changes the http_status_code attribute to nil' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(200).to(nil)
  end

  it 'changes the status attribute to :error' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('up').to('error')
  end

  it 'updates the last problem' do
    expect { subject }.to change { WebAddressRepository.new.find(web_address.id).last_problem }
      .from(nil).to(exception.message)
  end
end