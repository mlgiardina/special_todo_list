class Todo_List < ActiveRecord::Base
  belongs_to :user
  has_many :todos
end

# fields
#-list_name
#-user_id
#-todo_id
