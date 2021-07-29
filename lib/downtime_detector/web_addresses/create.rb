require 'hanami/interactor'

module WebAddresses
  class Create
    include Hanami::Interactor

    def initialize(url:, user:)
      @validation = UrlValidator.new(url: url).validate
      @user = user
    end

    def call
      web_address = WebAddressRepository.new.find_or_create_by_url(@validation.output[:url])

      if UserHavingWebAddressRepository.new.by_associations(user_id: @user.id, web_address_id: web_address.id)
        error('URL already exists')
      else
        UserHavingWebAddressRepository.new.create(user_id: @user.id, web_address_id: web_address.id)
      end
    end

    private

      def valid?
        @validation.success? || error(@validation.errors(full: true).values.flatten.join(', '))
      end
  end
end