class SessionsController < ApplicationController
  include RecaptchaValidatable

  before_action :authenticate_user, only: :destroy
  before_action -> { validate_recaptcha(action: 'sign_in/sign_up') }, only: :create

  def create
    outcome = AuthenticationInteraction.run(nickname: params[:nickname], password: params[:password])

    if outcome.valid?
      sign_in(outcome.result)
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
    end

    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
