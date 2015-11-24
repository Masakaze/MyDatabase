class AddReadReminderToTaskInfo < ActiveRecord::Migration
  def change
    add_column :task_infos, :read_reminder, :boolean, default: false, null:false
  end
end
