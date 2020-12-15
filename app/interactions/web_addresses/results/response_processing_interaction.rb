module WebAddresses
  module Results
    class ResponseProcessingInteraction < BaseProcessingInteraction
      object :response, class: Faraday::Response

      private

        def set_web_address_status
          web_address.update!(http_status_code: http_status_code, status: resolve_web_address_status)
        end

        def create_problem
          web_address.problems.create!(name: http_status_code, description: response.reason_phrase)
        end

        def resolve_web_address_status
          response.status.in?(100...400) ? :up : :down
        end

        def http_status_code
          response.status
        end
    end
  end
end
