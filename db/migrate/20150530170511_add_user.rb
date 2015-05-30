class AddUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :todo_list_id, null: false
  end
end
