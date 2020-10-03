class SessionsController < ApplicationController
  before_action :authenticate_user, only: :destroy

  def create
    outcome = AuthenticationInteraction.run(nickname: params[:nickname], password: params[:password])

    if outcome.valid?
      sign_in(outcome.result)
      flash[:success] = 'signed in'
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
    end

    redirect_to root_path
  end

  def destroy
    flash[:success] = 'signed out'
    sign_out

    redirect_to root_path
  end
end
