module Mailers
  class UserNotification
    include Hanami::Mailer

    from    'info@downtimedetector.xyz'
    to      :email
    subject 'A problem occured!'
  end
end
