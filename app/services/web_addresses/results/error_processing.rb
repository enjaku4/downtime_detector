module WebAddresses
  module Results
    class ErrorProcessing < BaseProcessing
      private

        def post_initialize(args)
          @exception = args[:exception]
        end

        def set_web_address_status
          @web_address.update!(http_status_code: nil, status: :error)
        end

        def create_problem
          @web_address.problems.create!(name: @exception.class, description: @exception.message)
        end
    end
  end
end
