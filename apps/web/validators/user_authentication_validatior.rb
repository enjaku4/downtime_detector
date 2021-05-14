module Web
  module Validators
    class UserAuthenticationValidator
      include Hanami::Validations::Form

      validations do
        required(:nickname) { str? & filled? & min_size?(6) }
        required(:password) { str? & filled? & min_size?(6) }
      end
    end
  end
end