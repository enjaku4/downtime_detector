class CreateWebAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :web_addresses do |t|
      t.integer :http_status_code
      t.datetime :pinged_at
      t.string :url, null: false, index: { unique: true }
      t.integer :status, null: false

      t.timestamps
    end
  end
end
