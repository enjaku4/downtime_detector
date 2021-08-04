module PingingService
  module Results
    class ResponseProcessor < BaseProcessor
      private

        def post_initialize(args)
          @response = args[:response]
        end

        def status
          (100...400).include?(http_status_code) ? 'up' : 'down'
        end

        def http_status_code
          @response.status
        end

        def message
          @response.reason_phrase
        end
    end
  end
end