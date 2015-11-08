class CreateTaskInfoLogs < ActiveRecord::Migration
  def change
    create_table :task_info_logs do |t|
      t.string :content
      t.integer :task_info_id

      t.timestamps null: false
    end

    add_foreign_key :task_info_logs, :task_infos, column: :task_info_id
  end
end
