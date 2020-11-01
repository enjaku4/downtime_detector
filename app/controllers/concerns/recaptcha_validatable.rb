module RecaptchaValidatable
  extend ActiveSupport::Concern

  private

    def validate_recaptcha
      if Rails.env.production? && !verify_recaptcha(action: 'sign_in/sign_up', minimum_score: 0.5)
        flash[:danger] = flash[:recaptcha_error]
        flash.delete(:recaptcha_error)
        redirect_to root_path
      end
    end
end
