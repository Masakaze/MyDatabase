
describe "IndexPage" do

  view_status_select_id = "view_status_select"
  view_category_select_id = "view_category_select"
  category_name_id = "task_category_name"

  it "IndexPage have" do
    visit task_infos_path

    expect(page).to have_content "タイトル"
    expect(page).to have_content "詳細"

    # タイトルがshowpageへのリンクになっている
    link_to_show_page_id = "title_link"
    first("div#title_div").click_on first("a##{link_to_show_page_id}").text
    expect(find("#page_file_name").value).to eq "show.html.erb" # showページのURLを確認する方法がなかったのでhidden_field_tagを使用した苦肉の索
  end

  it "IndexPage view_status_select" , js: true do
    visit task_infos_path

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

  it "IndexPage select by category" , js: true do
    visit task_infos_path

    # selectタグがある
    expect(find("select##{view_category_select_id}")).not_to eq nil

=begin
    # カテゴリ表示のタグがある(ひとまずダミーデータ用)
    expect(all("##{category_name_id}").find("[value='#{TaskCategory.task_category_test.name_jp}']")).not_to eq nil

    # 「ダミー」カテゴリを選択したら未定カテゴリのタスクは存在しない
    select_category_name = TaskCategory.task_category_test.name_jp
    select select_category_name, from: view_category_select_id
    jquery_id = "##{view_category_select_id}"
    page.evaluate_script("$('#{jquery_id}').trigger('change')") # onchangeはselectの値を設定しただけでは発生しないのでchangeをtriggerする
    p all("##{category_name_id}").first("[value='#{TaskCategory.task_category_undefined.name_jp}']")
    expect(all("##{category_name_id}").first("[value='#{TaskCategory.task_category_undefined.name_jp}']")).to eq nil
=end
  end

end
