module Web
  module Controllers
    module User
      class DeleteEmail
        include Web::Action

        def call(params)
          UserRepository.new.update(current_user.id, email: nil)

          redirect_to routes.root_path
        end
      end
    end
  end
end