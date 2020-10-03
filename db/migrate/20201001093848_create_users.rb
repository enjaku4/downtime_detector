class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname, null: false, index: { unique: true }
      t.string :password_hash, null: false
      t.string :password_salt, null: false

      t.timestamps
    end
  end
end
