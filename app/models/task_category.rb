class TaskCategory < ActiveRecord::Base

  has_many :task_infos
end
