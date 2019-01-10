class Category < ApplicationRecord
	##
	# Category properties (property_name: type => db_column_name: type?)
	#	* id: integer => id: primary key
	#	* name: string => name
	#	* created_at: timestamp => created_at
	#	* updated_at: timestamp => updated_at

	# Associations
	# belongs_to :categories_task_list
	# TODO: needs :through?
	has_many :task_lists#, :through => :categories_task_list

	# Validations
	validates :name, presence: true, length: { maximum: 100, too_long: "The name must be fewer than 100 characters." }
end
