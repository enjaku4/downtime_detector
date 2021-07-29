require_relative '../../../shared/controllers/recaptcha_validation'

module Web
  module Controllers
    module WebAddresses
      class Create
        include Web::Action
        include RecaptchaValidation

        before { validate_recaptcha(action: 'create_web_address', redirect_path: routes.new_web_address_path) }

        def call(params)
          result = ::WebAddresses::Create.new(url: params[:web_address][:url], user: current_user).call

          if result.successful?
            redirect_to routes.root_path
          else
            flash[:danger] = result.error
            redirect_to routes.new_web_address_path
          end
        end
      end
    end
  end
end
