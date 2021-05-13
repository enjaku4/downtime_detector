require 'hanami/interactor'

module Web
  module Interactors
    class AuthenticateUser
      include Hanami::Interactor

      def initialize(params)
        @validation = Validators::UserAuthenticationValidator.new(params).validate
      end

      expose :user

      def call
        @user = UserRepository.new.first_by_nickname(@validation.output[:nickname])

        if @user
          error!('password is incorrect') unless @user.password_correct?(@validation.output[:password])
        else
          @user = User.create(@validation.output)
        end
      end

      private

        def valid?
          @validation.success? || error(@validation.messages(full: true).values.join(', '))
        end
    end
  end
end
