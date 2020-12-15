require 'rails_helper'
require 'interactions/web_addresses/results/base_processing_interaction'

describe WebAddresses::Results::ErrorProcessingInteraction do
  subject { described_class.run!(web_address: web_address, exception: Faraday::TimeoutError.new) }

  let(:web_address) { create(:web_address, http_status_code: 200, status: :up) }

  it_behaves_like "the processing of the web address pinging result with \'faulty\' status"

  it 'changes the http_status_code attribute to nil' do
    expect { subject }.to change { web_address.http_status_code }.from(200).to(nil)
  end

  it 'changes the status attribute to :error' do
    expect { subject }.to change { web_address.status }.from('up').to('error')
  end

  it 'creates a new problem' do
    expect { subject }
      .to change { web_address.problems.where(name: 'Faraday::TimeoutError', description: 'timeout').count }
      .from(0).to(1)
  end
end
