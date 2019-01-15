class CreateCategoriesTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :task_lists do |t|
      t.index :category_id
      t.index :task_list_id
    end
  end
end
