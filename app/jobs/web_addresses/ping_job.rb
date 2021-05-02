module WebAddresses
  class PingJob < ApplicationJob
    rescue_from Faraday::Error do |exception|
      Results::ErrorProcessing.new(@web_address, exception: exception).run
    end

    def perform(web_address_id)
      @web_address = WebAddress.find(web_address_id)

      response = Faraday.get(@web_address.url) { |request| request.options.timeout = 10 }
      Results::ResponseProcessing.new(@web_address, response: response).run
    end
  end
end
