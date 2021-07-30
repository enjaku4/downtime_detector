Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :web_address_statuses, ['unknown', 'up', 'down', 'error']

    create_table :web_addresses do
      primary_key :id

      column :http_status_code, Integer
      column :notifications_sent, FalseClass, default: false, null: false
      column :pinged_at, DateTime
      column :status, 'web_address_statuses', default: 'unknown', null: false
      column :url, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :url, unique: true
    end
  end
end