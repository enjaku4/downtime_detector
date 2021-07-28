module Auth
  module Controllers
    module Session
      class New
        include Auth::Action

        def call(params)
          redirect_to Web.routes.root_path if user_authenticated?
        end
      end
    end
  end
end
