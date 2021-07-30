module Web
  module Controllers
    module WebAddresses
      class Index
        include Web::Action

        expose :web_addresses

        def call(params)
          raise StandardError, 'test'
          @web_addresses = WebAddressRepository.new.belonging_to_user(current_user.id)
        end
      end
    end
  end
end
