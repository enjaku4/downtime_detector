require 'hanami/interactor'

module WebAddresses
  class Destroy
    include Hanami::Interactor

    def initialize(web_address:, user:)
      @web_address = web_address
      @user = user
    end

    def call
      UserHavingWebAddressRepository.new.delete_association(user_id: @user.id, web_address_id: @web_address.id)
      WebAddressRepository.new.delete(@web_address.id) if WebAddressRepository.new.orphaned?(@web_address.id)
    end
  end
end