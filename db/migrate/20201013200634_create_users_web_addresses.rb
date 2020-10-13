class CreateUsersWebAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :users_web_addresses, id: false do |t|
      t.belongs_to :user
      t.belongs_to :web_address
    end
  end
end
