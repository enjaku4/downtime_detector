class WebAddressesController < ApplicationController
  include RecaptchaValidatable

  before_action :authenticate_user
  before_action -> { validate_recaptcha(action: 'create_web_address') }, only: :create

  def index
    @web_addresses = current_user.web_addresses.order(:url)
  end

  def show
    @web_address = WebAddress.find(params[:id])
    @problems = @web_address.problems.latest
  end

  def new
    @web_address = WebAddress.new
  end

  def create
    outcome = WebAddresses::CreationInteraction.run(url: params[:web_address][:url], user: current_user)

    if outcome.valid?
      redirect_to action: :index
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to action: :new
    end
  end

  def destroy
    WebAddresses::DeletionInteraction.run!(web_address: WebAddress.find(params[:id]), user: current_user)
    redirect_to action: :index
  end
end
