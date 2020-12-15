module WebAddresses
  class PingJob < ApplicationJob
    rescue_from Faraday::Error do |exception|
      WebAddresses::Results::ErrorProcessingInteraction.run!(web_address: @web_address, exception: exception)
    end

    def perform(web_address_id)
      @web_address = WebAddress.find(web_address_id)

      response = Faraday.get(@web_address.url) { |request| request.options.timeout = 5 }
      WebAddresses::Results::ResponseProcessingInteraction.run!(web_address: @web_address, response: response)
    end
  end
end
