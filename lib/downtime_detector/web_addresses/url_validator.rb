module WebAddresses
  class UrlValidator
    include Hanami::Validations

    validations do
      required(:url).filled(:str?, format?: URI.regexp)
    end
  end
end