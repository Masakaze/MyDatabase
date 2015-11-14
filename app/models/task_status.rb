class TaskStatus < ActiveRecord::Base

  validates :name_jp, :uniqueness => true, :presence => true

  belongs_to :next_task_status, :class_name => "TaskStatus", :foreign_key => :next_task_status_id
  belongs_to :prev_task_status, :class_name => "TaskStatus", :foreign_key => :prev_task_status_id

  def self.task_status_not_started
    TaskStatus.find_by(:name_jp => "未着手")
  end

  def self.task_status_start
    TaskStatus.find_by(:name_jp => "作業中")
  end

  def self.task_status_finish
    TaskStatus.find_by(:name_jp => "完了")
  end
end
