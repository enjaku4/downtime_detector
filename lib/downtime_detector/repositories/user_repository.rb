class UserRepository < Hanami::Repository
  associations do
    has_many :user_having_web_addresses
    has_many :web_addresses, through: :user_having_web_addresses
  end

  def find_by_nickname(nickname)
    users.where(nickname: nickname).one
  end
end
