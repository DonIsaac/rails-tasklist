class CreateCategoriesTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :task_lists

  end
end
