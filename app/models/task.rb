class Task < ApplicationRecord
	## 
	# Task properties (property_name: type => db_column_name: type?)
	#	* id: integer => id: primary key
	# 	* task_list: TaskList => task_list_id: foreign key
	#	* name: string => name
	#	* status: enum => status: integer
	#	* description: string => description: text
	#	* position: integer => position
	#	* created_at: timestamp => created_at
	#	* updated_at: timestamp => updated_at

	# Associations
	belongs_to :task_list
	acts_as_list scope: :task_list
	

	# Virtual Properties
	enum status: { created: 10, completed: 20, deleted: 30 }

	# Validations
	validates :task_list, presence: true
	validates :name, presence: { message: "Task name cannot be empty."}, length: { maximum: 100, too_long: "The name must be fewer than 100 characters." }
	validates :status, :inclusion => { :in => statuses.keys, message: "Invalid status." }, presence: { message: "A status must be provided."}
	validates :description, length: { maximum: 25000, too_long: "The description must be fewer than 25,000 characters."}
	validates :position, numericality: { only_integer: true }
end
