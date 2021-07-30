Hanami::Model.migration do
  change do
    create_table :user_having_web_addresses do
      primary_key :id

      foreign_key :user_id, :users, null: false, on_delete: :cascade
      foreign_key :web_address_id, :web_addresses, null: false, on_delete: :cascade

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :user_id
      index :web_address_id

      index [:user_id, :web_address_id], unique: true
    end
  end
end
