class UsersController < ApplicationController
  before_action :authenticate_user

  def update_email
    outcome = Users::Emails::UpdateInteraction.run(user: current_user, email: params[:email])

    flash[:danger] = outcome.errors.full_messages.to_sentence if outcome.invalid?

    redirect_to root_path
  end

  def delete_email
    Users::Emails::DeletionInteraction.run!(user: current_user)

    redirect_to root_path
  end
end
