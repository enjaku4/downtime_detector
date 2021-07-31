module Web
  module Controllers
    module User
      class UpdateEmail
        include Web::Action

        def call(params)
          result = Users::UpdateEmail.new(user: current_user, email: params.dig(:user, :email)).call

          flash[:danger] = result.error unless result.successful?

          redirect_to routes.root_path
        end
      end
    end
  end
end