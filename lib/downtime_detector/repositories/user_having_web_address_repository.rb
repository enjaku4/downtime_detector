class UserHavingWebAddressRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :web_address
  end

  def exists?(user_id:, web_address_id:)
    user_having_web_addresses.exist?(user_id: user_id, web_address_id: web_address_id)
  end

  def delete_association(user_id:, web_address_id:)
    delete(user_having_web_addresses.where(user_id: user_id, web_address_id: web_address_id).one.id)
  end
end
