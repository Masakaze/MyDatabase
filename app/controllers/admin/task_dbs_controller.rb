class Admin::TaskDbsController < ApplicationController
  def index
    render
  end

  # 全てのTaskInfoを再度saveする
  def resave_task_infos
    errors = []

    TaskInfo.all.each { |task_info|
      errors << task_info if task_info.save == false
    }

    error_msg = ""
    errors.each { |error|
      error_msg += "#{error.id}: #{error.erros.messages}\n"
    }
    respond_to do |format|
      format.html { redirect_to admin_task_db_path, notice: error_msg }
    end
  end
end
