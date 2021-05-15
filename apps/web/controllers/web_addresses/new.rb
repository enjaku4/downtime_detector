module Web
  module Controllers
    module WebAddresses
      class New
        include Web::Action

        before { authenticate_user }

        def call(params)
        end
      end
    end
  end
end
