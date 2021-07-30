require_relative 'base_processor'

describe PingingService::Results::ResponseProcessor do
  subject { described_class.new(web_address, response: response).call }

  let(:web_address) { Fabricate(:web_address, http_status_code: nil, status: 'unknown') }

  context 'if the http status code is 100' do
    let(:response) { Faraday::Response.new(status: 100) }

    it_behaves_like "the processing of the web address pinging result with \'up\' status"

    it 'changes the http_status_code attribute to 100' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(nil).to(100)
    end

    it 'changes the status attribute to :up' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('unknown').to('up')
    end
  end

  context 'if the http status code is 200' do
    let(:response) { Faraday::Response.new(status: 200) }

    it_behaves_like "the processing of the web address pinging result with \'up\' status"

    it 'changes the http_status_code attribute to 200' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(nil).to(200)
    end

    it 'changes the status attribute to :up' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('unknown').to('up')
    end
  end

  context 'if the http status code is 300' do
    let(:response) { Faraday::Response.new(status: 300) }

    it_behaves_like "the processing of the web address pinging result with \'up\' status"

    it 'changes the http_status_code attribute to 300' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(nil).to(300)
    end

    it 'changes the status attribute to :up' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('unknown').to('up')
    end
  end

  context 'if the http status code is 400' do
    let(:response) { Faraday::Response.new(status: 400, reason_phrase: 'bad request') }

    it_behaves_like "the processing of the web address pinging result with \'faulty\' status"

    it 'changes the http_status_code attribute to 400' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(nil).to(400)
    end

    it 'changes the status attribute to :down' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('unknown').to('down')
    end
  end

  context 'if the http status code is 500' do
    let(:response) { Faraday::Response.new(status: 500, reason_phrase: 'internal server error') }

    it_behaves_like "the processing of the web address pinging result with \'faulty\' status"

    it 'changes the http_status_code attribute to 500' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).http_status_code }.from(nil).to(500)
    end

    it 'changes the status attribute to :down' do
      expect { subject }.to change { WebAddressRepository.new.find(web_address.id).status }.from('unknown').to('down')
    end
  end
end