#
# @file		seeds_task_db.rb
# @brief	TaskDB用のseed
#

module SeedsHelperTaskDB

  def self.try_add_new_record(model_inst, inst_name)
    abort("#{model_inst.class.to_s}:(#{inst_name})の初期化に失敗\n#{model_inst.errors.messages}") if model_inst.save == false
    puts "#{model_inst.class.to_s}:(#{inst_name})を追加"
    return true
  end

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
        try_add_new_record(task_time_type, task_time_type.name_jp)
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
        try_add_new_record(task_status, task_status.name_jp)
      end
    }

    # TaskCategory
    init_task_category = [
                          {:name_jp => "未定"},
                          {:name_jp => "タスクDB"},
                         ]
    if Rails.env.development? || Rails.env.test?
      init_task_category << {:name_jp => "テストデータ用カテゴリ"}
    end
    init_task_category.each { |info|
      task_category = TaskCategory.find_or_create_by(info)
      if task_category.new_record?
        try_add_new_record(task_category, task_category.name_jp)
      end
    }

  end

end
