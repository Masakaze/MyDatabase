require 'spec_helper'

describe "TaskStatus" do
  it "TaskStatusFlow starts with 'not_started' and ends with 'finish'" do
    task_status = TaskStatus.task_status_not_started

    all_task_status_num = TaskStatus.all.size
    count = 1
    while true do
      break if task_status.task_status_flow.next_id == nil
      break if count >= all_task_status_num
      task_status = TaskStatus.find(task_status.task_status_flow.next_id)
      count += 1
    end
    
    expect(task_status.id).to eq TaskStatus.task_status_finish.id
  end
end
