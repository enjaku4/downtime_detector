module PingingService
  class UsersNotificationWorker
    include Sidekiq::Worker

    def perform(web_address_id)
      web_address = WebAddressRepository.new.find_with_users(web_address_id)

      web_address.users.each do |user|
        next if Hanami::Utils::Blank.blank?(user.email)

        mailer_class(web_address).deliver_async(email: user.email, web_address_id: web_address.id)
      end
    end

    private

      def mailer_class(web_address)
        web_address.faulty? ? Mailers::ProblemNotification : Mailers::ProblemSolvedNotification
      end
  end
end
