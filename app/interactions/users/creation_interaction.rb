module Users
  class CreationInteraction < ActiveInteraction::Base
    string :nickname
    string :password

    def execute
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)

      User.create!(nickname: nickname, password_salt: password_salt, password_hash: password_hash)
    end
  end
end
