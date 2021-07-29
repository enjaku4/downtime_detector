module Auth
  class UserValidator
    include Hanami::Validations

    validations do
      required(:nickname) { filled? & str? & min_size?(6) }
      required(:password) { filled? & str? & min_size?(6) }
    end
  end
end