class TaskInfoLog < ActiveRecord::Base
  belongs_to :task_info

  def self.type_text; return "text"; end
  def self.type_picture; return "picture"; end

  def is_type_text; return self.log_type == TaskInfoLog.type_text || log_type == nil; end
  def is_type_picture; return self.log_type == TaskInfoLog.type_picture; end
end
