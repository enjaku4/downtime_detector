module WebAddresses
  class CreationInteraction < ActiveInteraction::Base
    string :url
    object :user

    validates :url, presence: true, format: { with: URI.regexp, message: 'must be valid' }

    def execute
      web_address = WebAddress.find_or_initialize_by(url: url)

      if user.web_addresses.exists?(web_address.id)
        errors.add(:url, :exists)
      else
        user.web_addresses << web_address
      end
    end
  end
end
