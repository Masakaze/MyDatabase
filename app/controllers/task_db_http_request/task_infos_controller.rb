class TaskDbHttpRequest::TaskInfosController < ApplicationController

  protect_from_forgery with: :null_session

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
    task_info = TaskInfo.find(params[:id])

    if task_info == nil
      respond_to { |format| format.html { render :text => "failed" } }
      return false
    end

    task_info_log = nil
    if params[:task_info_logs] != nil && params[:task_info_logs][:content] != nil
      if params[:task_info_logs][:id] == nil
        task_info_log = TaskInfoLog.create(:task_info_id => params[:id])
      else
        task_info_log = TaskInfoLog.find(params[:task_info_logs][:id])
      end
      task_info_log.content = params[:task_info_logs][:content]
    end

    if task_info_log == nil
      respond_to { |format| format.html { render :text => "failed" } }
      return false
    end

    if task_info_log.new_record?
      task_info.task_info_logs << task_info_log
      task_info.save
    else
      task_info_log.save
    end

    respond_to do |format|
      format.html { render :text => "success" }
    end
  end

  # GET
  # リマインダフラグを立てる
  def read_reminder
    task_info_id = params[:task_info_id]
    task_info = TaskInfo.find(task_info_id)

    task_info.read_reminder = true
    msg = task_info.save ? "success" : "failed"
    respond_to do |format|
      format.html { render :text => msg }
    end
  end

  # POST
  # アップロードコメントをTaskDBに送信
  def upload_comment
    task_info = TaskInfo.find(params[:id])
    task_info_log = TaskInfoLog.new(:content => params[:upload_comment], :log_type => TaskInfoLog.type_text)
    msg = ""

    if task_info == nil
      msg = "TaskInfo not found(id:#{params[:id]})"
    elsif params[:upload_comment]
      msg = "Params should have upload comment."
    else
      task_info << task_info_log
      msg = "success" if task_info.save
    end

    respond_to do |format|
      format.html { render :text => msg }
    end
  end

end
