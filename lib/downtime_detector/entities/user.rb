class User < Hanami::Entity
  def password_correct?(password)
    BCrypt::Password.new(self.password) == password
  end
end
