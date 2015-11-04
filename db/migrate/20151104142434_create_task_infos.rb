class CreateTaskInfos < ActiveRecord::Migration
  def change
    create_table :task_infos do |t|
      t.string :title
      t.string :detail

      t.timestamps null: false
    end
  end
end
