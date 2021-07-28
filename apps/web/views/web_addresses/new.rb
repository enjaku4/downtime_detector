module Web
  module Views
    module WebAddresses
      class New
        include Web::View
        include RecaptchaFormHelper
      end
    end
  end
end
