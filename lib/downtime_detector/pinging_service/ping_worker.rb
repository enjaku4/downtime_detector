module PingingService
  class PingWorker
    include Sidekiq::Worker

    def perform(web_address_id)
      web_address = WebAddressRepository.new.find(web_address_id)
      response = Faraday.get(web_address.url) { |request| request.options.timeout = 10 }
      Results::ResponseProcessing.new(web_address, response: response).call
    rescue Faraday::Error => exception
      Results::ErrorProcessing.new(web_address, exception: exception).call
    end
  end
end