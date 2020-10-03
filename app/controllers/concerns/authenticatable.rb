module Authenticatable
  extend ActiveSupport::Concern

  included { helper_method :current_user }

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session[:user_id] = nil
    end

    def authenticate_user
      redirect_to root_path unless current_user
    end
end
