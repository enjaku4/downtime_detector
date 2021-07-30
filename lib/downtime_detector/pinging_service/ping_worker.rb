module PingingService
  class PingWorker
    include Sidekiq::Worker

    def perform(web_address_id)
      web_address = WebAddressRepository.new.find(web_address_id)
      response = Faraday.get(web_address.url) { |request| request.options.timeout = 10 }
      Results::ResponseProcessor.new(web_address, response: response).call
    rescue Faraday::Error => exception
      Results::ErrorProcessor.new(web_address, exception: exception).call
    end
  end
end