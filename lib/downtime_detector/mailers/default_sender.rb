module Mailers
  module  DefaultSender
    def self.included(mailer)
      mailer.class_eval do
        from 'info@downtime-detector.herokuapp.com'
        to :email
      end
    end
  end
end
