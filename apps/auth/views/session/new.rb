require_relative '../../../shared/views/recaptcha_form_helper'

module Auth
  module Views
    module Session
      class New
        include Auth::View
        include RecaptchaFormHelper
      end
    end
  end
end
