class CategoriesTaskList < ApplicationRecord
	##
	# CategoriesTaskList properties (property_name: type => db_column_name: type?)
	#	* id: integer => id: primary key
	#	* task_list: TaskList => task_list_id: foreign key
	#	* category: Category => category_id: foreign key

	# Associations
	has_one :task_list, validate: { presence: true }
	has_one :category, validate: { presence: true }
end
