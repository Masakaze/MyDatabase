require 'spec_helper'

describe "ShowPage" do
  info = {:title => "ダミータイトル", :detail => "ダミー詳細"}
  task_info = TaskInfo.create(info)
  task_finish_button_id = "task_finish_button"
  create_task_info_log_button = "作業メモ追加"
  create_task_info_log_button_id = "create_task_info_log_button"
  show_task_info_log_id = "show_task_info_log"

  it "ShowPage have" do
    visit task_info_path(task_info)

    expect(page).to have_content info[:title]
    expect(page).to have_content info[:detail]
#    expect(find("input##{task_finish_button_id}")).not_to eq nil
    expect(find("##{create_task_info_log_button_id}")).not_to eq nil
    #expect(find("##{show_task_info_log_id}")).to eq nil # 存在しないことを検証したかったけどelementが見つからない時点でエラーがでてしまった
  end

  # タスクのステータスを次の状態へ
  it "Task status change to next" do
    task_info.task_status = TaskStatus.find_by(:name_jp => "未着手")
    visit task_info_path(task_info)
    next_status = TaskStatus.find(task_info.task_status.task_status_flow.next_id)
    click_button "#{next_status.name_jp}に変更する"
    expect(TaskInfo.find(task_info.id).task_status_id).to eq next_status.id
  end

  # タスクのステータスを前の状態へ
  it "Task status change to prev" do
    task_info.task_status = TaskStatus.find_by(:name_jp => "完了")
    visit task_info_path(task_info)
    prev_status = TaskStatus.find(task_info.task_status.task_status_flow.prev_id)
    click_button "#{prev_status.name_jp}に変更する"
    expect(TaskInfo.find(task_info.id).task_status_id).to eq prev_status.id
  end

  # 作業メモを書いた
  it "If task_info_log exist" do
    visit task_info_path(task_info)

    fill_in "作業メモ", with: "作業メモテスト"
    log_num = task_info.task_info_logs != nil ? task_info.task_info_logs.size : 0
    expect{ click_button create_task_info_log_button }.to change(TaskInfoLog, :count).by(1)
    expect(TaskInfo.find(task_info.id).task_info_logs.size).to eq log_num+1
    expect(find("##{show_task_info_log_id}")).not_to eq nil
  end

end
