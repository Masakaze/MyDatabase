class TaskInfo < ActiveRecord::Base

  belongs_to :estimate_task_type, :class => "TaskTimeType"
  belongs_to :task_status

  before_save :before_save_callback

  def before_save_callback
    self.task_status_id = TaskStatus.task_status_not_started.id if self.task_status_id == nil
  end
end
