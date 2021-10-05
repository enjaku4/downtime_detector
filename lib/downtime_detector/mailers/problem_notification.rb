module Mailers
  class ProblemNotification
    include Hanami::Mailer

    to      :email
    subject 'A problem occured'

    private

      def web_address
        @web_address ||= WebAddressRepository.new.find(web_address_id)
      end
  end
end
