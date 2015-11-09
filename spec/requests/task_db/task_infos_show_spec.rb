require 'spec_helper'

describe "ShowPage" do
  info = {:title => "ダミータイトル", :detail => "ダミー詳細"}
  task_info = TaskInfo.create(info)
  task_start_button = "タスク開始"
  task_finish_button = "タスク完了"
  task_finish_button_id = "task_finish_button"
  create_task_info_log_button = "作業メモ追加"
  create_task_info_log_button_id = "create_task_info_log_button"
  show_task_info_log_id = "show_task_info_log"

  it "ShowPage have" do
    visit task_info_path(task_info)

    expect(page).to have_content info[:title]
    expect(page).to have_content info[:detail]
    expect(find("input##{task_finish_button_id}")).not_to eq nil
    expect(find("##{create_task_info_log_button_id}")).not_to eq nil
    #expect(find("##{show_task_info_log_id}")).to eq nil # 存在しないことを検証したかったけどelementが見つからない時点でエラーがでてしまった
  end

  # タスク開始
  it "Task start" do
    visit task_info_path(task_info)
    click_button task_start_button
    expect(TaskInfo.find(task_info.id).task_status_id).to eq TaskStatus.task_status_start.id
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

  # タスク完了
  it "Task finish" do
    visit task_info_path(task_info)
    click_button task_finish_button
    expect(TaskInfo.find(task_info.id).task_status_id).to eq TaskStatus.task_status_finish.id
  end
end
