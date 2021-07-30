module Auth
  class UserValidator
    include Hanami::Validations::Form

    validations do
      required(:nickname) { filled? & min_size?(6) }
      required(:password) { filled? & min_size?(6) }
    end
  end
end