class AddLogTypeToTaskInfoLog < ActiveRecord::Migration
  def change
    add_column :task_info_logs, :log_type, :string
  end
end
