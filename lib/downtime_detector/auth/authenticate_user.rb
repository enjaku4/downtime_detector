require 'hanami/interactor'

module Auth
  class AuthenticateUser
    include Hanami::Interactor

    def initialize(nickname:, password:, user_repository: UserRepository.new)
      @validation = UserValidator.new(nickname: nickname, password: password).validate
      @user_repository = user_repository
    end

    expose :user

    def call
      @user = @user_repository.by_nickname(@validation.output[:nickname])
      @user ? check_password_correctness : create_user
    end

    private

      def valid?
        @validation.success? || error(@validation.errors(full: true).values.flatten.join(', '))
      end

      def check_password_correctness
        error('password is incorrect') unless @user.password_correct?(@validation.output[:password])
      end

      def create_user
        password_hash = BCrypt::Password.create(@validation.output[:password])
        @user = @user_repository.create(nickname: @validation.output[:nickname], password: password_hash)
      end
  end
end