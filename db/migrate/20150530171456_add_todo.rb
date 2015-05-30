class AddTodo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :entry, null: false
      t.boolean :completed, default: false
      t.integer :user_id, null: false
      t.integer :todo_list_id
    end
  end
end
