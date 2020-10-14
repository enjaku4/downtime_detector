module WebAddresses
  class PingJob < ApplicationJob
    rescue_from Faraday::Error do
      @web_address.mark_as_faulty!
    end

    def perform(web_address_id)
      @web_address = WebAddress.find(web_address_id)
      http_status_code = Faraday.get(@web_address.url).status
      @web_address.set_ping_result!(http_status_code)
    end
  end
end
