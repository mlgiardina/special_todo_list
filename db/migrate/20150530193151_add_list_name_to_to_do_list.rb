class AddListNameToToDoList < ActiveRecord::Migration
  def change
    add_column(:todo_lists, :list_name, :string, null: false, default: "no name")
  end
end
