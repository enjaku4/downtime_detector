module Users
  class EmailValidator
    include Hanami::Validations::Form

    validations do
      required(:email).filled(format?: URI::MailTo::EMAIL_REGEXP)
    end
  end
end