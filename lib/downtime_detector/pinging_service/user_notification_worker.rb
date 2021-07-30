module PingingService
  class UsersNotificationWorker
    include Sidekiq::Worker

    def perform(web_address_id)
      # TODO notifications
      # web_address = WebAddressRepository.find(web_address_id)

      # web_address.users.with_email.each do |user|
      #   UserMailer.notification(web_address.url, user.email).deliver_later
      # end
      puts "Notification: ID##{web_address_id}"
    end
  end
end