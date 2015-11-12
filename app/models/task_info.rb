class TaskInfo < ActiveRecord::Base

  belongs_to :estimate_task_time_type, :class_name => "TaskTimeType"
  belongs_to :task_status
  belongs_to :task_category
  has_many :task_info_logs, :autosave => true

  before_save :before_save_callback

  def before_save_callback
    self.task_status_id = TaskStatus.task_status_not_started.id if self.task_status_id == nil
    self.task_category_id = TaskCategory.task_category_undefined.id if self.task_category_id == nil
  end
end
