class AddTodoList < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.integer :user_id, null: false
      t.integer :todo_id, null: false
  end
end
