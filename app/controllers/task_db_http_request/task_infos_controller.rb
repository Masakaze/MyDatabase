class TaskDbHttpRequest::TaskInfosController < ApplicationController

  # テスト用
  def new
    task_info = TaskInfo.find_by(:task_category_id => TaskCategory.task_category_test.id)
    task_info.detail = "スクリプトからのPostテスト"
    task_info.detail = params[:detail] if params[:detail]!= nil
    task_info.save

    redirect_to task_info_path(task_info)
  end

  def create
    task_info = TaskInfo.find_by(:task_category_id => TaskCategory.task_category_test.id)
    task_info.detail = "スクリプトからのPostテスト"
    task_info.save

    head :ok
  end
end
