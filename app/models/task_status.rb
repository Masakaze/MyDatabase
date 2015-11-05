class TaskStatus < ActiveRecord::Base

  def self.task_status_not_started
    TaskStatus.find_by(:name_jp => "未着手")
  end

  def self.task_status_finish
    TaskStatus.find_by(:name_jp => "完了")
  end
end
