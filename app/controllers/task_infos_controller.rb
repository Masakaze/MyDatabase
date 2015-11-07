class TaskInfosController < ApplicationController
  before_action :set_task_info, only: [:show, :edit, :update, :destroy, :finish_task]

  # GET /task_infos
  # GET /task_infos.json
  def index
    @task_infos = TaskInfo.all
  end

  # GET /task_infos/1
  # GET /task_infos/1.json
  def show
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

  # PUT /task_infos/1/finish_task
  def finish_task
    @task_info.task_status_id = TaskStatus.task_status_finish.id
    msg = @task_info.save ? "Task finish" : "Task finish process failed"
    respond_to do |format|
      format.html { redirect_to task_info_path(@task_info), notice: msg }
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
      params.require(:task_info).permit(:title, :detail, :estimate_task_time_type_id)
    end
end
