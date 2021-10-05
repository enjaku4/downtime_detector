module Mailers
  module  DefaultSender
    def self.included(mailer)
      mailer.class_eval do
        from 'info@downtimedetector.xyz'
        to :email
      end
    end
  end
end
