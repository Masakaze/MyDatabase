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

    fill_in "タイトル", with: "テスト"
    fill_in "詳細", with: "テストの詳細"
    select TaskTimeType.first.name_jp, from: estimate_time_select_id

    expect { click_button create_button }.to change(TaskInfo, :count).by(1)
  end
end

describe "ShowPage" do

end

describe "IndexPage" do

end
