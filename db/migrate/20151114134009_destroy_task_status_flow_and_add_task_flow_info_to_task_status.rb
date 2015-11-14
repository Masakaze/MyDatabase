class DestroyTaskStatusFlowAndAddTaskFlowInfoToTaskStatus < ActiveRecord::Migration
  def change
    drop_table :task_status_flows

    add_column :task_statuses, :next_task_status_id, :integer
    add_foreign_key :task_statuses, :task_statuses, column: :next_task_status_id
    add_column :task_statuses, :prev_task_status_id, :integer
    add_foreign_key :task_statuses, :task_statuses, column: :prev_task_status_id
    
  end
end
