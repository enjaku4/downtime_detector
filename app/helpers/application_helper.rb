module ApplicationHelper
  def recaptcha_for(action:)
    recaptcha_v3(action: action, turbolinks: true) if Rails.env.in?(['production', 'test'])
  end
end
