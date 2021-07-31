require 'hanami/interactor'

module Users
  class UpdateEmail
    include Hanami::Interactor

    def initialize(user:, email:)
      @validation = EmailValidator.new(email: email).validate
      @user = user
    end

    def call
      UserRepository.new.update(@user.id, email: @validation.output[:email])
    end

    private

      def valid?
        @validation.success? || error(@validation.errors(full: true).values.flatten.join(', '))
      end
  end
end