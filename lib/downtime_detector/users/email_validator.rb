module Users
  class EmailValidator
    include Hanami::Validations::Form

    validations do
      required(:url).filled(format?: URI::MailTo::EMAIL_REGEXP)
    end
  end
end