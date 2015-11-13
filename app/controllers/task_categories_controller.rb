class TaskCategoriesController < ApplicationController

  # GET /task_category/new
  def new
    @task_category = TaskCategory.new
  end

  # POST /task_category/
  def create
  end
end
