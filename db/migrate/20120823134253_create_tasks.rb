class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :due_date
      t.integer :priority
      t.boolean :completed
      t.references :user
    end
    add_index :tasks, :user_id
  end
end
