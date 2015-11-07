namespace :db do
  desc "create dummy task_info"
  task create_dummy_task_info: :environment do
    status_num = TaskStatus.all.size
    100.times { |n|
      info = {
        :title => "ダミータスクタイトル#{n+1}",
        :detail => "ダミータスク詳細#{n+1}",
        :task_status_id => (n % status_num) + 1
      }
      TaskInfo.create!(info)
    }
  end
end
