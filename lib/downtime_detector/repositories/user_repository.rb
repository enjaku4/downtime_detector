class UserRepository < Hanami::Repository
  def by_nickname(nickname)
    users.where(nickname: nickname).one
  end
end
