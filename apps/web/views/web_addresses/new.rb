require_relative '../../../shared/views/recaptcha_form_helper'

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
