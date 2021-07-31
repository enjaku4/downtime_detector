module Users
  class EmailValidator
    include Hanami::Validations

    validations do
      required(:email).maybe(:filled?, format?: URI::MailTo::EMAIL_REGEXP)
    end
  end
end