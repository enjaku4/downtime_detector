module Users
  class VerificationInteraction < ActiveInteraction::Base
    object :user
    string :password

    validate :password_correctness

    def execute
      user
    end

    private

      def password_correctness
        if user.password_hash != BCrypt::Engine.hash_secret(password, user.password_salt)
          errors.add(:password, :incorrect)
        end
      end
  end
end
