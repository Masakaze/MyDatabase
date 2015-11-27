class TaskInfoLogsController < ApplicationController
  before_action :set_task_info_log, only: [:update]

  # POST /task_info_logs
  def create
    task_info = TaskInfo.find(task_info_log_params[:task_info_id])

    if task_info_log_params[:log_type] == "picture" && 
        ( (/^http[s]?:\/\/[\w\d\.\/]*/ =~ task_info_log_params[:content]) == nil || (/\s/ =~ task_info_log_params[:content]) != nil )
      respond_to do |format|
        format.html { redirect_to task_info, notice: 'Please write picture url' }
      end
      return false
    end

    @task_info_log = TaskInfoLog.new(task_info_log_params)

    respond_to do |format|
      if @task_info_log.save
        format.html { redirect_to task_info, notice: 'TaskInfoLog was successfully created.' }
      else
        format.html { redirect_to task_info, notice: 'TaskInfoLog create faild.' }
      end
    end
  end

  # PUT /task_info_logs/1
  def update
    if params[:commit] == "更新"
      @task_info_log_content_view = task_info_log_params[:content]
      @task_info_log.content = task_info_log_params[:content]
      @is_success = @task_info_log.save
    else
      @task_info_log_content_view = @task_info_log.content
      @is_success = false
    end
    @task_info_log_id = params[:id]

  end

  private
  def set_task_info_log
    @task_info_log = TaskInfoLog.find(params[:id])
  end

  def task_info_log_params
    params.require(:task_info_log).permit(:content, :task_info_id, :log_type)
  end
end
