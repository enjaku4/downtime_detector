class User < Hanami::Entity
  def self.create(nickname:, password:)
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password, password_salt)

    UserRepository.new.create(nickname: nickname, password_salt: password_salt, password_hash: password_hash)
  end

  def password_correct?(password)
    password_hash == BCrypt::Engine.hash_secret(password, password_salt)
  end
end
