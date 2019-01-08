class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :limit => 32, :default => "Anonymous User"
      t.string :username, :null => false, :limit => 64
      t.string :password_digest, :null => false
      t.integer :status, :null => false, :default => 0

      t.timestamps
    end
  end
end
