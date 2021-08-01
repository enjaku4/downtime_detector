module PingingService
  module Results
    class ErrorProcessor < BaseProcessor
      private

        def post_initialize(args)
          @exception = args[:exception]
        end

        def update_web_address_status
          WebAddressRepository.new.update(@web_address.id, http_status_code: nil, status: 'error')
        end

        def update_last_problem
          WebAddressRepository.new.update(@web_address.id, last_problem: @exception.message)
        end
    end
  end
end