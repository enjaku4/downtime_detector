Hanami::Model.migration do
  change do
    alter_table :web_addresses do
      add_column :last_problem, String
    end
  end
end
