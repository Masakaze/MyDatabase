class TaskInfoLogsController < ApplicationController
  before_action: set_task_info_log, only: [:create]

  # POST /task_info_logs
  def create
  end

  private
  def set_task_info_log
    @task_info_log = TaskInfoLog.find(param[:id])
  end

  def task_info_log_params
    params.require(:task_info_log).permit(:content, :task_info_id)
  end
end
