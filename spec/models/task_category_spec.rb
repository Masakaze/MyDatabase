require 'spec_helper'

describe "TaskCategory" do
  it "name_jp is unique" do
    info = { :name_jp => "テストカテゴリー" }
    task_category = TaskCategory.new(info)
    expect( task_category.valid? ).to eq true

    # name_jpがunique
    task_category = TaskCategory.new(info)
    expect( task_category.valid? ).to eq false
  end
end
