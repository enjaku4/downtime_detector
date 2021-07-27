module Auth
  class UserValidator
    include Hanami::Validations

    validations do
      required(:nickname) { str? & filled? & min_size?(3) }
      required(:password) { str? & filled? & min_size?(6) }
    end
  end
end