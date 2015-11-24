require 'spec_helper'

describe "read_reminder" do
  it "read_reminder should" do
    task_info_id = TaskInfo.first
    task_info = TaskInfo.find(task_info_id)
    expect(task_info.read_reminder).to eq false

    visit "#{task_infos_path}/read_reminder?task_info_id=#{task_info_id}"

    task_info = TaskInfo.find(task_info_id)
    expect(task_info.read_reminder).to eq true
  end
end
