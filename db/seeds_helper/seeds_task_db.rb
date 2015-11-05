#
# @file		seeds_task_db.rb
# @brief	TaskDB用のseed
#

module SeedsHelperTaskDB

  def self.execute
    # TaskTimeType
    init_task_time_type = [
                           {:name_jp => "30分", :value => 30},
                           {:name_jp => "1時間", :value => 60},
                           {:name_jp => "半日", :value => 60*12},
                           {:name_jp => "1日", :value => 60*24},
                          ]
    init_task_time_type.each { |info|
      task_time_type = TaskTimeType.find_or_create_by(info)
      if task_time_type.new_record?
        abort("TaskTimeType(#{info[:name_jp]})の初期化に失敗\n#{task_time_type.errors.messages}") if task_time_type.save == false
        puts "TaskTimeType(#{task_time_type.name_jp})を追加"
      end
    }

    # TaskStatus
    init_task_status = [
                        {:name_jp => "未着手"},
                        {:name_jp => "作業中"},
                        {:name_jp => "完了"},
                        ]
    init_task_status.each { |info|
      task_status = TaskStatus.find_or_create_by(info)
      if task_status.new_record?
        abort("TaskStatus:(#{task_status.name_jp})の追加に失敗\n#{task_status.errors.messages}") if task_status.save == false
        puts "TaskStatus:(#{task_status.name_jp})追加"
      end
    }

  end

end
