module WebAddresses
  class DeletionInteraction < ActiveInteraction::Base
    object :web_address
    object :user

    def execute
      user.web_addresses.destroy(web_address)
      web_address.destroy if web_address.users.empty?
    end
  end
end
