module PingingService
  module Results
    class BaseProcessor
      def initialize(web_address, args)
        @web_address = web_address
        @web_address_was_faulty = web_address.faulty?

        post_initialize(args)
      end

      def call
        WebAddressRepository.new.update(
          @web_address.id,
          status: status,
          http_status_code: http_status_code,
          message: message,
          pinged_at: Time.now
        )

        @web_address = WebAddressRepository.new.find(@web_address.id)

        UsersNotificationWorker.perform_async(@web_address.id) if @web_address_was_faulty != @web_address.faulty?
      end

      private

        def post_initialize(args)
          raise NotImplementedError
        end

        def status
          raise NotImplementedError
        end

        def http_status_code
          raise NotImplementedError
        end

        def message
          raise NotImplementedError
        end
    end
  end
end
