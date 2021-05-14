module Web
  module Controllers
    module Session
      class New
        include Web::Action

        def call(params)
          redirect_to routes.web_addresses_path if user_authenticated?
        end
      end
    end
  end
end
