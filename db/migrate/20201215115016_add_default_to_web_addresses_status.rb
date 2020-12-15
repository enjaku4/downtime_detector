class AddDefaultToWebAddressesStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :web_addresses, :status, from: nil, to: 0
  end
end
