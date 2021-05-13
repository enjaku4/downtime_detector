class UserRepository < Hanami::Repository
  def first_by_nickname(nickname)
    users.where(nickname: nickname).first
  end
end
