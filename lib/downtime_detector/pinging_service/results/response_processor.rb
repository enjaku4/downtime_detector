module PingingService
  module Results
    class ResponseProcessor < BaseProcessor
      private

        def post_initialize(args)
          @response = args[:response]
        end

        def update_web_address_status
          WebAddressRepository.new
            .update(@web_address.id, http_status_code: http_status_code, status: resolve_web_address_status)
        end

        def resolve_web_address_status
          (100...400).include?(http_status_code) ? 'up' : 'down'
        end

        def http_status_code
          @response.status
        end
    end
  end
end