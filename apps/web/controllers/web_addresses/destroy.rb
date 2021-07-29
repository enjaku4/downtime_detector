module Web
  module Controllers
    module WebAddresses
      class Destroy
        include Web::Action

        def call(params)
          ::WebAddresses::Destroy.new(web_address: WebAddressRepository.new.find(params[:id]), user: current_user).call

          redirect_to routes.root_path
        end
      end
    end
  end
end
