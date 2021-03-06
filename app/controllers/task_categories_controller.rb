class TaskCategoriesController < ApplicationController

  # GET /task_category/new
  def new    
    @task_category = TaskCategory.new
    @is_open_from_other = params[:is_open_from_other]
  end

  # POST /task_category/
  def create
    @task_category = TaskCategory.new(task_category_params)
    @is_success = @task_category.save
    msg =  @is_success ? "Task category was successfully added" : "Add task category failed"
    respond_to do |format|
      format.html { redirect_to task_infos_path, :notice => msg }
      format.js { render 'create' }
    end
  end

  private
  def task_category_params
    params.require(:task_category).permit(:name_jp)
  end
end
