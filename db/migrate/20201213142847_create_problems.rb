class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :name, null: false
      t.text :description
      t.belongs_to :web_address, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
