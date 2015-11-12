# bundle exec rake db:resave_all_task_info RAILS_ENV=test

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

  desc "resave_all_task_info"
  task resave_all_task_info: :environment do
    TaskInfo.all.each { |task_info|
      abort("#{task_info.title}(id:#{task_info.id}の保存に失敗\n#{task_info.errors.messages}") if task_info.save == false
    }
  end
end
