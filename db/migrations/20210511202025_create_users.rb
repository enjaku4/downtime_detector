Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :email, String
      column :nickname, String, null: false
      column :password_hash, String, null: false
      column :password_salt, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :nickname, unique: true
    end
  end
end
