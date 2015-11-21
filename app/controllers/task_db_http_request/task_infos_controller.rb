class TaskDbHttpRequest::TaskInfosController < ApplicationController

  # テスト用
  def new
=begin
    task_info = TaskInfo.find_by(:task_category_id => TaskCategory.task_category_test.id)
    task_info.detail = "スクリプトからのPostテスト"
    task_info.detail = params[:detail] if params[:detail]!= nil
    task_info.save
=end

    require 'yaml'
    respond_to do |format|
      format.html { render :text => params.to_yaml }
    end
  end

  def create
    params[:id] = 11
    params[:task_info_logs] = {}
    params[:task_info_logs][:content] = "Test"
    task_info = TaskInfo.find(params[:id])
    abort if task_info == nil
    task_info_log = nil
    if params[:task_info_logs] != nil && params[:task_info_logs][:content] != nil
      task_info_log = TaskInfoLog.create(:content => params[:task_info_logs][:content], :task_info_id => params[:id])
    end
    abort if task_info_log == nil

    task_info.task_info_logs << task_info_log
    task_info.save

    head :ok
  end

end
