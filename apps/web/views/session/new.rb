module Web
  module Views
    module Session
      class New
        include Web::View
        include Helpers::RecaptchaFormHelper

        def new_session_form
          form_for :session, routes.session_path do
            div recaptcha_for(action: 'sign_in/sign_up')
            div(class: 'form-group') do
              text_field :nickname, placeholder: 'nickname', class: 'form-control'
            end
            div(class: 'form-group') do
              password_field :password, placeholder: 'password', class: 'form-control'
            end
            submit 'Sign in / Sign up', class: 'btn btn-primary'
          end
        end
      end
    end
  end
end
