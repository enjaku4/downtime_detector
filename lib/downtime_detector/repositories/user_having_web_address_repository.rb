class UserHavingWebAddressRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :web_address
  end

  def by_associations(user_id:, web_address_id:)
    user_having_web_addresses.where(user_id: user_id, web_address_id: web_address_id).one
  end

  def by_web_address_id(web_address_id)
    user_having_web_addresses.where(web_address_id: web_address_id).to_a
  end
end
