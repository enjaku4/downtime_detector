require 'hanami/interactor'

module Web
  module Interactors
    class AuthenticateUser
      include Hanami::Interactor

      def initialize(nickname:, password:)
        @nickname = nickname
        @password = password
      end

      expose :user

      def call
        @user = UserRepository.new.find_by_nickname(@nickname)

        if @user
          error!('password is incorrect') unless @user.password_correct?(@password)
        else
          @user = User.create(nickname: @nickname, password: @password)
        end
      end

      private

        def valid?
          validation = Validators::UserAuthenticationValidator.new(nickname: @nickname, password: @password).validate
          validation.success? || error(validation.messages(full: true).values.join(', '))
        end
    end
  end
end
