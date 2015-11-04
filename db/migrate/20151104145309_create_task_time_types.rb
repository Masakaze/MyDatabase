class CreateTaskTimeTypes < ActiveRecord::Migration
  def change
    create_table :task_time_types do |t|
      t.string :name_jp
      t.integer :value

      t.timestamps null: false
    end
  end
end
