require 'spec_helper'

describe "NewPage" do

  estimate_time_select_id = "estimate_time_select"
  create_button = "Create Task info"

  it "NewPage have" do
    visit new_task_info_path

    # 見積もり時間のselectタグが存在
    expect(find("select##{estimate_time_select_id}")).not_to eq nil
  end

  it "Correct Info" do
    visit new_task_info_path

    info = { :title => "タイトルテスト", :detail => "テスト詳細", :estimate_task_time_type_id => TaskTimeType.first.id }

    fill_in "タイトル", with: info[:title]
    fill_in "詳細", with: info[:detail]
    select TaskTimeType.find(info[:estimate_task_time_type_id]).name_jp, from: estimate_time_select_id

    expect { click_button create_button }.to change(TaskInfo, :count).by(1)
    task_info = TaskInfo.find_by(info)
    expect(task_info).not_to eq nil
    expect(task_info.task_status_id).to eq TaskStatus.task_status_not_started.id

  end
end

describe "ShowPage" do
  info = {:title => "ダミータイトル", :detail => "ダミー詳細"}
  task_info = TaskInfo.create(info)
  task_finish_button = "タスク完了"
  task_finish_button_id = "TaskFinishButton"

  it "ShowPage have" do
    visit task_info_path(task_info)

    expect(page).to have_content info[:title]
    expect(page).to have_content info[:detail]
    expect(find("input##{task_finish_button_id}")).not_to eq nil
  end

  it "Task finish" do
    visit task_info_path(task_info)

    expect { click_button task_finish_button }.to eq ( task_info.task_status_id == TaskStatus.task_status_finish.id )
  end
end

describe "IndexPage" do
  it "IndexPage have" do
    visit task_infos_path

    expect(page).to have_content "タイトル"
    expect(page).to have_content "詳細"
  end
end
