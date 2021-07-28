Hanami::Model.migration do
  change do
    alter_table :users do
      drop_column :password_salt
      rename_column :password_hash, :password
    end
  end
end
