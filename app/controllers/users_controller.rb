class UsersController < ApplicationController
  before_action :authenticate_user

  def update_email
    outcome = Users::EmailUpdateInteraction.run(user: current_user, email: params[:email])

    flash[:danger] = outcome.errors.full_messages.to_sentence if outcome.invalid?

    redirect_to root_path
  end

  def delete_email
    Users::EmailDeletionInteraction.run!(user: current_user)

    redirect_to root_path
  end
end
