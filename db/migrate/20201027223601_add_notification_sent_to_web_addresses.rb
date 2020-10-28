class AddNotificationSentToWebAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :web_addresses, :notification_sent, :boolean, default: false, null: false
  end
end
