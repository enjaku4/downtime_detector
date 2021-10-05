module Mailers
  module  DefaultSender
    def self.included(mailer)
      mailer.class_eval do
        from 'info@downtimedetector.xyz'
      end
    end
  end
end
