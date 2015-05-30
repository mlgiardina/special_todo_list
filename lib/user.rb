class User < ActiveRecord::Base
  has_many :todos
  belongs_to :todo_list
end
