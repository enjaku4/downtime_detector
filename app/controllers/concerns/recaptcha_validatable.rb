module RecaptchaValidatable
  extend ActiveSupport::Concern

  private

    def validate_recaptcha(action:)
      if Rails.env.in?(['production', 'test']) && !verify_recaptcha(action: action, minimum_score: 0.7)
        flash[:danger] = flash[:recaptcha_error]
        flash.delete(:recaptcha_error)
        redirect_back fallback_location: root_path
      end
    end
end
