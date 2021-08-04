module PingingService
  module Results
    class BaseProcessor
      def initialize(web_address, args)
        @web_address = web_address
        post_initialize(args)
      end

      def call
        update_web_address_pinging_data
        reload_web_address

        @web_address.status == 'up' ? reset_notifications : notify_users
      end

      private

        def post_initialize(args)
          raise NotImplementedError
        end

        def update_web_address_pinging_data
          WebAddressRepository.new.update(
            @web_address.id,
            status: status,
            http_status_code: http_status_code,
            message: message,
            pinged_at: Time.now
          )
        end

        def reload_web_address
          @web_address = WebAddressRepository.new.find(@web_address.id)
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

        def reset_notifications
          WebAddressRepository.new.update(@web_address.id, notifications_sent: false)
        end

        def notify_users
          unless @web_address.notifications_sent
            UsersNotificationWorker.perform_async(@web_address.id)
            WebAddressRepository.new.update(@web_address.id, notifications_sent: true)
          end
        end
    end
  end
end