class TaskInfosController < ApplicationController
  before_action :set_task_info, only: [:show, :edit, :update, :destroy, :task_status_change]

  # GET /task_infos
  # GET /task_infos.json
  def index
#    @task_infos = TaskInfo.all
    @view_status_name = params[:view_status_name]
    if @view_status_name == nil || @view_status_name == ""
      @task_infos = TaskInfo.includes(:task_status).where("task_status_id not in (#{TaskStatus.task_status_finish.id})")
    else
      @task_infos = TaskInfo.includes(:task_status).where("task_status_id in (#{TaskStatus.find_by(:name_jp => @view_status_name).id})")
    end

    @view_category_name = params[:view_category_name]
    view_category = TaskCategory.find_by(:name_jp => @view_category_name)
    if view_category != nil
      @task_infos = @task_infos.where(:task_category_id => view_category.id)
    end

    respond_to do |format|
      format.html
      format.xml {
        task_info_xmls = @task_infos.map { |c|
          {
            :task_info => c, 
            :add_info => {:estimate_progress => c.calc_estimate_progress}
          }
        }
        render :xml => task_info_xmls
      }
    end
  end

  # GET /task_infos/1
  # GET /task_infos/1.json
  def show
    respond_to do |format|
      format.html
      format.xml { render :xml => @task_info }
    end
  end

  # GET /task_infos/new
  def new
    @task_info = TaskInfo.new
  end

  # GET /task_infos/1/edit
  def edit
  end

  # POST /task_infos
  # POST /task_infos.json
  def create
    @task_info = TaskInfo.new(task_info_params.merge(:task_status_id => TaskStatus.task_status_not_started.id))

    respond_to do |format|
      if @task_info.save
        format.html { redirect_to @task_info, notice: 'Task info was successfully created.' }
        format.json { render :show, status: :created, location: @task_info }
      else
        format.html { render :new }
        format.json { render json: @task_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_infos/1
  # PATCH/PUT /task_infos/1.json
  def update
    respond_to do |format|
      if @task_info.update(task_info_params)
        format.html { redirect_to @task_info, notice: 'Task info was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_info }
      else
        format.html { render :edit }
        format.json { render json: @task_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_infos/1
  # DELETE /task_infos/1.json
  def destroy
    @task_info.destroy
    respond_to do |format|
      format.html { redirect_to task_infos_url, notice: 'Task info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /task_infos/1/task_status_change
  def task_status_change
    if @task_info.task_status_id != params[:task_status_id]
      # タスク時間計測周り
      case params[:task_status_id].to_i
      when TaskStatus.task_status_not_started.id then
        @task_info.real_task_time = 0
      when TaskStatus.task_status_start.id then
        @task_info.task_start_time = Time.now()
      when TaskStatus.task_status_abort.id then
        @task_info.real_task_time = @task_info.calc_task_time
      when TaskStatus.task_status_finish.id then
        @task_info.real_task_time = @task_info.calc_task_time
      end

      @task_info.task_status_id = params[:task_status_id] # real_task_timeの更新計算自体は前のステータスでないとだめなのでステータス更新はこのタイミング
      task_info_log = TaskInfoLog.new(:content => "進捗を#{@task_info.task_status.name_jp}に変更", :task_info_id => @task_info.id)
      @task_info.task_info_logs << task_info_log
    end
    msg = @task_info.save ? "Task status changed" : "Task status change process failed"
    respond_to do |format|
      format.html { 
        redirect_to @task_info.task_status_id == TaskStatus.task_status_finish.id ? task_infos_path : task_info_path(@task_info), notice: msg
      }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_info
      @task_info = TaskInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_info_params
      params.require(:task_info).permit(:title, :detail, :estimate_task_time_type_id, :task_category_id)
    end
end
