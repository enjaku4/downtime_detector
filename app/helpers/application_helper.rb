module ApplicationHelper
  def recaptcha_for(action:)
    recaptcha_v3(action: 'sign_in/sign_up') if Rails.env.production?
  end
end
