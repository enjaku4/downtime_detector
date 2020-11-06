module ApplicationHelper
  def recaptcha_for(action:)
    recaptcha_v3(action: action) if Rails.env.production?
  end
end
