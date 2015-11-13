require 'spec_helper'

describe "TaskCategory new page" do

  task_category_name_jp_id = "task_category_name_jp"
  add_category_button_name = 'カテゴリー追加'

  it "TaskCategory new page have" do
    visit new_task_category_path

    # 日本語名入力欄がある
    expect( find("input##{task_category_name_jp_id}") ).not_to eq nil

    # 追加ボタンがある
    expect( find_button add_category_button_name ).not_to eq nil
  end

  it "Add TaskCategory" do
    visit new_task_category_path

    info = { :name_jp => "テストカテゴリ" }

    fill_in "日本語名", with: info[:name_jp]
    expect { click_button add_category_button_name }.to change(TaskCategory, :count).by(1)
  end

end
