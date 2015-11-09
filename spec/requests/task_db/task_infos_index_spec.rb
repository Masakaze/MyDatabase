
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
