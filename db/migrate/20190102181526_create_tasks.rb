class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :task_list, :null => false#, index: true
      t.integer :status, :null => false, :default => 10
      t.string :name, :null => false, :limit => 100
      t.text :description, :limit => 25000
      t.integer :position

      t.timestamps
    end
  end
end