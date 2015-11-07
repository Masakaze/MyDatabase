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
  task_start_button = "タスク開始"
  task_finish_button = "タスク完了"
  task_finish_button_id = "task_finish_button"

  it "ShowPage have" do
    visit task_info_path(task_info)

    expect(page).to have_content info[:title]
    expect(page).to have_content info[:detail]
    expect(find("input##{task_finish_button_id}")).not_to eq nil
  end

  it "Task start" do
    visit task_info_path(task_info)
    click_button task_start_button
    expect(TaskInfo.find(task_info.id).task_status_id).to eq TaskStatus.task_status_start.id
  end

  it "Task finish" do
    visit task_info_path(task_info)
    click_button task_finish_button
    expect(TaskInfo.find(task_info.id).task_status_id).to eq TaskStatus.task_status_finish.id
  end
end

describe "IndexPage" do
  it "IndexPage have" do
    visit task_infos_path

    expect(page).to have_content "タイトル"
    expect(page).to have_content "詳細"
  end

  it "IndexPage view_status_select" , js: true do
    visit task_infos_path

    view_status_select_id = "view_status_select"
    view_status_selects = [["", ""]] + TaskStatus.all.map{ |s| [s.name_jp, "#{s.name_jp}のみ表示"] }
    view_status_selects.each { |view_status_select|
      select view_status_select[1], from: view_status_select_id
      jquery_id = "##{view_status_select_id}"
      page.evaluate_script("$('#{jquery_id}').trigger('change')") # onchangeはselectの値を設定しただけでは発生しないのでchangeをtriggerする
#      sleep 1

      if view_status_select[1] == ""
        # デフォルトでは完了タスクは非表示に
        page.all("#show_task_status").each { |show_task_status|
          expect(show_task_status.text).not_to eq TaskStatus.task_status_finish.name_jp
        }
      else
        # 選択した進捗のみ表示
        page.all("#show_task_status").each { |show_task_status|
          expect(show_task_status.text).to eq view_status_select[0]
        }
      end
    }
  end
end
