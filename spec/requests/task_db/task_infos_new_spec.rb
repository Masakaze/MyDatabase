require 'spec_helper'

describe "NewPage" do

  estimate_time_select_id = "estimate_time_select"
  category_select_id = "task_category_select"
  create_button = "Create Task info"
  add_task_category_button_name = "カテゴリー追加"

  it "NewPage have" do
    visit new_task_info_path

    # 見積もり時間のselectタグが存在
    expect(find("select##{estimate_time_select_id}")).not_to eq nil

    # カテゴリ選択のselectタグが存在
    expect(find("select##{category_select_id}")).not_to eq nil

    # 新規タスクカテゴリ追加ボタン
    expect(find_button add_task_category_button_name).not_to eq nil
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
