module RecaptchaValidation
  include Recaptcha::Adapters::ControllerMethods

  private

    def validate_recaptcha(action:, redirect_path:)
      options = {
        action: action,
        minimum_score: 0.7,
        response: params[:'g-recaptcha-response-data'][:"#{action}"],
        skip_remote_ip: true,
        env: Hanami.env
      }

      unless verify_recaptcha(options)
        flash[:danger] = 'recaptcha is invalid'
        redirect_to redirect_path
      end
    end
end