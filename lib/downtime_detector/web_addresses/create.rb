require 'hanami/interactor'

module WebAddresses
  class Create
    include Hanami::Interactor

    def initialize(url:, user:, web_address_repository: WebAddressRepository.new)
      @validation = UrlValidator.new(url: url).validate
      @user = user
      @web_address_repository = web_address_repository
    end

    def call
      web_address = @web_address_repository.find_or_create_by_url(@validation.output[:url])

      if UserHavingWebAddressRepository.new.exists?(user_id: @user.id, web_address_id: web_address.id)
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