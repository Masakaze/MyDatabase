require 'spec_helper'

$:.unshift(File.join( File.dirname(__FILE__), "task_db") )
require "task_infos_show_spec"

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

describe "IndexPage" do
  it "IndexPage have" do
    visit task_infos_path

    expect(page).to have_content "タイトル"
    expect(page).to have_content "詳細"

    # タイトルがshowpageへのリンクになっている
    link_to_show_page_id = "title_link"
    first("div#title_div").click_on first("a##{link_to_show_page_id}").text
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
