require 'hanami/interactor'

module WebAddresses
  class Destroy
    include Hanami::Interactor

    def initialize(web_address:, user:)
      @web_address = web_address
      @user = user
    end

    def call
      detach_web_address_from_user
      WebAddressRepository.new.delete(@web_address.id) if web_address_orphaned?
    end

    private

      def detach_web_address_from_user
        user_having_web_address = UserHavingWebAddressRepository.new
          .by_associations(user_id: @user.id, web_address_id: @web_address.id)
        UserHavingWebAddressRepository.new.delete(user_having_web_address.id)
      end

      def web_address_orphaned?
        UserHavingWebAddressRepository.new.by_web_address_id(@web_address.id).empty?
      end
  end
end