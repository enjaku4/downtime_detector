module Web
  module Validators
    class UserAuthenticationValidator
      include Hanami::Validations::Form

      validations do
        required(:nickname) { filled? & str? & min_size?(6) }
        required(:password) { filled? & str? & min_size?(9) }
      end
    end
  end
end