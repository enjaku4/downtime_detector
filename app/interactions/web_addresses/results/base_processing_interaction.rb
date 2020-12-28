module WebAddresses
  module Results
    class BaseProcessingInteraction < ActiveInteraction::Base
      object :web_address

      def execute
        set_web_address_status
        web_address.update_ping_time!

        web_address.reset_notifications! if web_address.up?

        if web_address.faulty?
          create_problem
          notify_users
        end
      end

      private

        def set_web_address_status
          raise NotImplementedError
        end

        def create_problem
          raise NotImplementedError
        end

        def notify_users
          unless web_address.notifications_sent?
            WebAddresses::UsersNotificationJob.perform_later(web_address.id)
            web_address.update!(notifications_sent: true)
          end
        end
    end
  end
end
