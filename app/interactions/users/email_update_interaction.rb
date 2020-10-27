module Users
  class EmailUpdateInteraction < ActiveInteraction::Base
    object :user
    string :email

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be valid' }

    def execute
      user.update!(email: email)
    end
  end
end
