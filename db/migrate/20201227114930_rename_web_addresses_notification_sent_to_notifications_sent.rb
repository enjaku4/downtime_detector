class RenameWebAddressesNotificationSentToNotificationsSent < ActiveRecord::Migration[5.2]
  def change
    rename_column :web_addresses, :notification_sent, :notifications_sent
  end
end
