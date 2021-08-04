module PingingService
  module Results
    class ErrorProcessor < BaseProcessor
      private

        def post_initialize(args)
          @exception = args[:exception]
        end

        def status
          'error'
        end

        def http_status_code
          nil
        end

        def message
          @exception.message
        end
    end
  end
end