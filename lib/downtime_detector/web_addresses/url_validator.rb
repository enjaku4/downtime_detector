module WebAddresses
  class UrlValidator
    include Hanami::Validations::Form

    validations do
      required(:url).filled(format?: URI.regexp)
    end
  end
end