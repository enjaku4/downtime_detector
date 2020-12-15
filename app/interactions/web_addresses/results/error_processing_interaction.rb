module WebAddresses
  module Results
    class ErrorProcessingInteraction < BaseProcessingInteraction
      object :exception, class: Faraday::Error

      private

        def set_web_address_status
          web_address.update!(http_status_code: nil, status: :error)
        end

        def create_problem
          web_address.problems.create!(name: exception.class, description: exception.message)
        end
    end
  end
end
