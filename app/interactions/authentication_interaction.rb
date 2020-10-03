class AuthenticationInteraction < ActiveInteraction::Base
  string :nickname
  string :password

  validates :nickname, :password, presence: true, length: { minimum: 6 }

  def execute
    user = User.find_by(nickname: nickname)

    if user
      compose(Users::VerificationInteraction, user: user, password: password)
    else
      compose(Users::CreationInteraction, nickname: nickname, password: password)
    end
  end
end
