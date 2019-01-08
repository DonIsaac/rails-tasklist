class CreateTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_table :task_lists do |t|
      t.string :name, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end
end
