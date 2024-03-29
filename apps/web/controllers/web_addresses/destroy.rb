module Web
  module Controllers
    module WebAddresses
      class Destroy
        include Web::Action

        def call(params)
          web_address = WebAddressRepository.new.find(params[:id])

          ::WebAddresses::Destroy.new(web_address: web_address, user: current_user).call if web_address

          redirect_to routes.root_path
        end
      end
    end
  end
end
