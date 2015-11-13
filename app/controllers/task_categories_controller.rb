class TaskCategoriesController < ApplicationController

  # GET /task_category/new
  def new
    @task_category = TaskCategory.new
  end

  # POST /task_category/
  def create
    @task_category = TaskCategory.new(task_category_params)
    msg = @task_category.save ? "Task category was successfully added" : "Add task category failed"
    respond_to do |format|
      format.html { redirect_to task_infos_path, :notice => msg }
    end
  end

  private
  def task_category_params
    params.require(:task_category).permit(:name_jp)
  end
end
