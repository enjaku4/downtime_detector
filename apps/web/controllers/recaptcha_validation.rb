module Web
  module Controllers
    module RecaptchaValidation
      include Recaptcha::Adapters::ControllerMethods

      private

        def validate_recaptcha(action:)
          options = {
            action: action,
            minimum_score: 0.7,
            response: params[:'g-recaptcha-response-data'][:"#{action}"],
            skip_remote_ip: true,
            env: Hanami.env
          }

          unless verify_recaptcha(options)
            flash[:danger] = 'recaptcha is invalid'
            redirect_to request.referer || routes.root_path
          end
        end
    end
  end
end