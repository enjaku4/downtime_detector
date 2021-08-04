Hanami::Model.migration do
  change do
    alter_table :web_addresses do
      rename_column :last_problem, :message
    end
  end
end
