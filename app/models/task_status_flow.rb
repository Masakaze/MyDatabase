class TaskStatusFlow < ActiveRecord::Base

  belongs_to :next_task_status, :class_name => "TaskStatus", :foreign_key => :next_id
  belongs_to :prev_task_status, :class_name => "TaskStatus", :foreign_key => :prev_id

  has_one :task_status, :autosave => true

end
