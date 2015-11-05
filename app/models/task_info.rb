class TaskInfo < ActiveRecord::Base

  belongs_to :estimate_task_type, :class => "TaskTimeType"
end
