class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@downtimedetector.xyz'
  layout 'mailer'
end
