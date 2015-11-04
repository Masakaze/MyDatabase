require 'spec_helper'

describe "NewPage" do
  it "NewPage have" do
    visit '/task_infos/new'

    # 見積もり時間のselectタグが存在
    expect(find("select#estimate_time_select")).not_to eq nil
  end
end

describe "ShowPage" do

end

describe "IndexPage" do

end
