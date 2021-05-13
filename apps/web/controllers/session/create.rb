module Web
  module Controllers
    module Session
      class Create
        include Web::Action
        include RecaptchaValidation

        before { validate_recaptcha(action: 'sign_in/sign_up') }

        def call(params)
          result = Interactors::AuthenticateUser.new(params[:session]).call

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
