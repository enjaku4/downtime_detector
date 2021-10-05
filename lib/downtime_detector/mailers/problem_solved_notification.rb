module Mailers
  class ProblemSolvedNotification
    include Hanami::Mailer

    to      :email
    subject 'Problem solved'

    private

      def web_address
        @web_address ||= WebAddressRepository.new.find(web_address_id)
      end
  end
end
