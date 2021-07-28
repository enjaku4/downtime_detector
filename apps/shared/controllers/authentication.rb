module Authentication
  def self.included(action)
    action.class_eval do
      expose :current_user
    end
  end

  private

    def authenticate_user
      redirect_to Auth.routes.root_path unless user_authenticated?
    end

    def user_authenticated?
      !!current_user
    end

    def current_user
      @current_user ||= UserRepository.new.find(session[:user_id])
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session[:user_id] = nil
    end
end
