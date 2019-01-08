class User < ApplicationRecord
  has_many :task_lists
  has_secure_password
end
