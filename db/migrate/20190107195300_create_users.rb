class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false, limit: 100
      t.string :crypted_password, null: false, limit: 40
      t.string :salt, null: false, limit: 40
      t.string :email, null: false, limit: 100
      t.string :firstname, null: false, limit: 100
      t.string :firstname, null: false, limit: 100

      t.timestamps
    end
  end
end
