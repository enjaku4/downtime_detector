class WebAddressRepository < Hanami::Repository
  associations do
    has_many :user_having_web_addresses
    has_many :users, through: :user_having_web_addresses
  end

  def find_or_create_by_url(url)
    web_addresses.where(url: url).one || create(url: url)
  end

  def belonging_to_user(user_id)
    web_addresses.join(:users).where(user_id: user_id).distinct.to_a
  end

  def orphaned?(id)
    web_addresses.join(:users).where(web_address_id: id).to_a.empty?
  end

  def ready_to_ping
    web_addresses.where(Sequel.lit('pinged_at IS NULL OR pinged_at < ?', Chronic.parse('5 minutes ago'))).to_a
  end

  def find_with_users(id)
    aggregate(:users).where(id: id).map_to(WebAddress).one
  end
end
