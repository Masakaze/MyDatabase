class AddRealTaskTimeAndTaskStartTimeToTaskInfo < ActiveRecord::Migration
  def change
    add_column :task_infos, :real_task_time, :integer
    add_column :task_infos, :task_start_time, :integer
  end
end
