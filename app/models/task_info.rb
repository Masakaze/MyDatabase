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

  # タスク経過時間を計算
  def calc_task_time
    if task_status_id == TaskStatus.task_status_finish.id && 
      real_task_time != nil && real_task_time != 0
      return real_task_time
    end
    if task_status_id == TaskStatus.task_status_abort.id && 
      real_task_time != nil && real_task_time != 0
      return real_task_time
    end
    return 0 if task_status_id == TaskStatus.task_status_not_started.id
    return 0 if task_start_time == nil # 仕様追加時の暫定対応
    calc_val = (Time.now() - task_start_time).to_i / 60
    calc_val += real_task_time if real_task_time != nil
    return calc_val
  end

  # 想定進捗率を%で計算
  def calc_estimate_progress
    return 0 if estimate_task_time_type == nil
    return (100.0 * calc_task_time / estimate_task_time_type.value).round
  end
end
