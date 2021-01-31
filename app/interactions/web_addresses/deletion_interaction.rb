module WebAddresses
  class DeletionInteraction < ActiveInteraction::Base
    object :web_address
    object :user

    def execute
      detach_web_address_from_user
      web_address.destroy if web_address.users.empty?
    end

    private

      def detach_web_address_from_user
        user.web_addresses.destroy(web_address)
      end
  end
end
