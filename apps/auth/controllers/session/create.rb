require_relative '../../../shared/controllers/recaptcha_validation'

module Auth
  module Controllers
    module Session
      class Create
        include Auth::Action
        include RecaptchaValidation

        before { validate_recaptcha(action: 'sign_in/sign_up', redirect_path: routes.root_path) }

        def call(params)
          result = Auth::AuthenticateUser.new(params[:session]).call

          if result.successful?
            sign_in(result.user)
          else
            flash[:danger] = result.error
          end

          redirect_to routes.root_path
        end
      end
    end
  end
end
