module Web
  module Controllers
    module WebAddresses
      class Index
        include Web::Action

        expose :web_addresses

        def call(params)
          @web_addresses = WebAddressRepository.new.by_user_id(current_user.id)
        end
      end
    end
  end
end
