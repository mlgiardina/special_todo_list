class Todo_List < ActiveRecord::Base
  has_many :users
  has_many :todos
end
