class TaskInfoLog < ActiveRecord::Base
  belongs_to :task_info

  def is_type_text; return self.log_type == "text" || log_type == nil; end
  def is_type_picture; return self.log_type == "picture"; end
end
