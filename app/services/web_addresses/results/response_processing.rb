module WebAddresses
  module Results
    class ResponseProcessing < BaseProcessing
      private

        def post_initialize(args)
          @response = args[:response]
        end

        def set_web_address_status
          @web_address.update!(http_status_code: http_status_code, status: resolve_web_address_status)
        end

        def create_problem
          @web_address.problems.create!(name: http_status_code, description: @response.reason_phrase)
        end

        def resolve_web_address_status
          http_status_code.in?(100...400) ? :up : :down
        end

        def http_status_code
          @response.status
        end
    end
  end
end
