class UserRepository < Hanami::Repository
  def find_by_nickname(nickname)
    users.where(nickname: nickname).first
  end
end
