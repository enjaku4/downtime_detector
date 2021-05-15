module Web
  module Views
    module WebAddresses
      class New
        include Web::View
        include Helpers::RecaptchaFormHelper

        def new_web_address_form
          form_for :web_address, routes.web_addresses_path do
            div recaptcha_for(action: 'create_web_address')
            div(class: 'form-group') do
              text_field :url, placeholder: 'https://www.example.com', class: 'form-control'
            end
            submit 'Add', class: 'btn btn-primary'
          end
        end
      end
    end
  end
end
