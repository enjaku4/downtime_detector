module PingingService
  module Results
    class BaseProcessor
      def initialize(web_address, args)
        @web_address = web_address
        post_initialize(args)
      end

      def call
        update_web_address_status
        update_pinged_at

        reload_web_address

        if @web_address.status == 'up'
          reset_notifications
        elsif @web_address.faulty?
          update_last_problem
          notify_users
        end
      end

      private

        def post_initialize(args)
          raise NotImplementedError
        end

        def update_web_address_status
          raise NotImplementedError
        end

        def update_pinged_at
          WebAddressRepository.new.update(@web_address.id, pinged_at: Time.now)
        end

        def reload_web_address
          @web_address = WebAddressRepository.new.find(@web_address.id)
        end

        def reset_notifications
          WebAddressRepository.new.update(@web_address.id, notifications_sent: false)
        end

        def update_last_problem
          raise NotImplementedError
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