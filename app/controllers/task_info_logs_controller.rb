class TaskInfoLogsController < ApplicationController
  before_action :set_task_info_log, only: []

  # POST /task_info_logs
  def create
    @task_info_log = TaskInfoLog.new(task_info_log_params)

    task_info = TaskInfo.find(task_info_log_params[:task_info_id])
    respond_to do |format|
      if @task_info_log.save
        format.html { redirect_to task_info, notice: 'TaskInfoLog was successfully created.' }
      else
        format.html { redirect_to task_info, notice: 'TaskInfoLog create faild.' }
      end
    end
  end

  private
  def set_task_info_log
    @task_info_log = TaskInfoLog.find(params[:id])
  end

  def task_info_log_params
    params.require(:task_info_log).permit(:content, :task_info_id)
  end
end
