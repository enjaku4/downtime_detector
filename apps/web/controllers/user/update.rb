module Web
  module Controllers
    module User
      class Update
        include Web::Action

        def call(params)
          if Hanami::Utils::Blank.filled?(params[:email])
            Users::UpdateEmail.new(user: current_user, email: params[:email]).call
          else
            UserRepository.new.update(current_user.id, email: nil)
          end

          redirect_to routes.root_path
        end
      end
    end
  end
end
