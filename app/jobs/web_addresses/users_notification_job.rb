module WebAddresses
  class UsersNotificationJob < ApplicationJob
    def perform(web_address_id)
      web_address = WebAddress.find(web_address_id)

      web_address.users.with_email.each do |user|
        UserMailer.notification(web_address.url, user.email).deliver_later
      end
    end
  end
end
