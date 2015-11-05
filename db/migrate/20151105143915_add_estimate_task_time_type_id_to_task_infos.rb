class AddEstimateTaskTimeTypeIdToTaskInfos < ActiveRecord::Migration
  def change
    add_column :task_infos, :estimate_task_time_type_id, :integer
  end
end
