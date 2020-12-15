module Users
  module Emails
    class DeletionInteraction < ActiveInteraction::Base
      object :user

      def execute
        user.update!(email: nil)
      end
    end
  end
end
