class TaskCategory < ActiveRecord::Base

  has_many :task_infos

  def self.task_category_undefined
    TaskCategory.find_by(:name_jp => "未定")
  end

  # デバッグ用
  def self.task_category_test
    TaskCategory.find_by(:name_jp => "テストデータ用カテゴリ")
  end
end
