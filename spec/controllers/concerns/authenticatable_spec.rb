require 'rails_helper'

describe Authenticatable, type: :controller do
  controller(ApplicationController) do
    include Authenticatable

    before_action :authenticate_user, only: [:authenticate_user_action]

    def current_user_action
      @current_user = current_user
      head :ok
    end

    def sign_in_action
      sign_in User.find(params[:id])
      head :ok
    end

    def sign_out_action
      sign_out
      head :ok
    end

    def authenticate_user_action
      head :ok
    end
  end

  before do
    routes.draw do
      get 'current_user_action' => 'anonymous#current_user_action'
      get 'sign_in_action' => 'anonymous#sign_in_action'
      get 'sign_out_action' => 'anonymous#sign_out_action'
      get 'authenticate_user_action' => 'anonymous#authenticate_user_action'
    end
  end

  describe '#current_user' do
    subject { get :current_user_action }

    context 'if there is no signed in user' do
      it 'returns nil' do
        subject
        expect(assigns(:current_user)).to eq(nil)
      end
    end

    context 'if the user is signed in' do
      let(:user) { create(:user) }

      before { session[:user_id] = user.id }

      it 'returns the user' do
        subject
        expect(assigns(:current_user)).to eq(user)
      end
    end
  end

  describe '#sign_in' do
    subject { get :sign_in_action, params: { id: user.id } }

    let(:user) { create(:user) }

    it "stores the user\'s id in the user\'s session" do
      expect { subject }.to change { session[:user_id] }.from(nil).to(user.id)
    end
  end

  describe '#sign_out' do
    subject { get :sign_out_action }

    before { session[:user_id] = 123 }

    it "cleans the user\'s session" do
      expect { subject }.to change { session[:user_id] }.from(123).to(nil)
    end
  end

  describe '#authenticate_user' do
    subject { get :authenticate_user_action }

    context 'if there is no signed in user' do
      it 'redirects to the root path' do
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'if the user is signed in' do
      let(:user) { create(:user) }

      before { session[:user_id] = user.id }

      it 'responds with the code 200' do
        expect(subject).to have_http_status(200)
      end
    end
  end
end
