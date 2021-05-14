module Web
  module Helpers
    module RecaptchaFormHelper
      include Recaptcha::Adapters::ViewMethods

      private

        def recaptcha_for(action:)
          raw recaptcha_v3(action: action)
        end
    end
  end
end