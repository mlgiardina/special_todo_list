class ChangeTodoColumn < ActiveRecord::Migration
  def change
    change_column(:todos, :todo_list_id, :string)
  end
end
