Hanami::Model.migration do
  change do
    alter_table :web_addresses do
      drop_column :notifications_sent
    end
  end
end
