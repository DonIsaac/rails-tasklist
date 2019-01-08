class TaskList < ApplicationRecord
	##
	# TaskList properties (property_name: type => db_column_name: type?)
	#	* id: integer => id: primary key
	#	* name: string => name
	#	* user: User => user_id: foreign key
	#	* created_at: timestamp => created_at
	#	* updated_at: timestamp => updated_at
	#	* tasks: Tasks[] => N/A: virtual property

	# Associations
	has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
	# belongs_to :categories_task_list
	has_many :categories, :through => :categories_task_list
	# belongs_to :user

	# Validations
	validates :name, presence: { message: "Task list name cannot be empty"}, length: { maximum: 100, too_long: "The name must be fewer than 100 characters."}
	validates :user_id, presence: true
end
