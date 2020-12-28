require 'rails_helper'

describe RecaptchaValidatable, type: :controller do
  controller(ApplicationController) do
    include RecaptchaValidatable

    before_action -> { validate_recaptcha(action: 'foo') }

    def fake_action() head :ok end
  end

  before do
    routes.draw do
      get 'fake_action' => 'anonymous#fake_action'
    end
  end

  describe '#validate_recaptcha' do
    subject { get :fake_action }

    context 'if the recaptcha is verified' do
      before { allow_any_instance_of(ApplicationController).to receive(:verify_recaptcha)
        .with(hash_including(action: 'foo')).and_return(true) }

      it 'responds with the code 200' do
        expect(subject).to have_http_status(200)
      end
    end

    context 'if the recaptcha is not verified' do
      before { allow_any_instance_of(ApplicationController).to receive(:verify_recaptcha)
        .with(hash_including(action: 'foo')).and_return(false) }

      it 'redirects to the root path' do
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
