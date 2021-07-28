module Web
  module Views
    module Session
      class New
        include Web::View
        include RecaptchaFormHelper
      end
    end
  end
end
