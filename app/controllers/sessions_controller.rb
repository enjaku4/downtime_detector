class SessionsController < ApplicationController
  before_action :authenticate_user, only: :destroy
  before_action :validate_recaptcha, only: :create, if: -> { Rails.env.production? }

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

  private

    def validate_recaptcha
      unless verify_recaptcha(action: 'sign_in/sign_up', minimum_score: 0.5)
        flash[:danger] = flash[:recaptcha_error]
        flash.delete(:recaptcha_error)
        redirect_to root_path
      end
    end
end
