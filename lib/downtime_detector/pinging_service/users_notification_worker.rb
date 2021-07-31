module PingingService
  class UsersNotificationWorker
    include Sidekiq::Worker

    def perform(web_address_id)
      web_address = WebAddressRepository.new.find_with_users(id)

      web_address.users.each do |user|
        next if Hanami::Utils::Blank.blank?(user.email)
        Mailers::UserNotification.deliver_async(email: user.email, url: web_address.url)
      end
    end
  end
end