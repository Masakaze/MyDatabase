require 'spec_helper'

describe "TaskInfos" do

  it "validation at create" do
    info = { :title => "タイトルテスト", :detail => "タイトル詳細" }
    # save前のtask_status_idはnil
    task_info = TaskInfo.new(info)
    expect(task_info.task_status_id).to eq nil
    # save後は未着手で初期化する
    task_info.save
    expect(task_info.task_status_id).to eq TaskStatus.task_status_not_started.id
    # before_saveが暴走してないかチェック
    TaskStatus.all.each { |task_status|
      task_info.task_status_id = task_status.id
      task_info.save
      expect(task_info.task_status_id).to eq task_status.id
    }
  end
end
