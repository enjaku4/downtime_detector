module Auth
  module Controllers
    module Session
      class Destroy
        include Auth::Action

        before { authenticate_user }

        def call(params)
          sign_out
          redirect_to routes.root_path
        end
      end
    end
  end
end
