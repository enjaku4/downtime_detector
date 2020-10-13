module WebAddresses
  class CreationInteraction < ActiveInteraction::Base
    string :url
    object :user

    validates :url, presence: true

    def execute
      web_address = WebAddress.find_or_initialize_by(url: url)

      unless user.web_addresses.exists?(web_address.id)
        web_address.status = :unknown
        user.web_addresses << web_address
      end
    end
  end
end
