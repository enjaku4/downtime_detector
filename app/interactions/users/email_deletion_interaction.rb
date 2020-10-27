module Users
  class EmailDeletionInteraction < ActiveInteraction::Base
    object :user

    def execute
      user.update!(email: nil)
    end
  end
end
