class AddViewPriorityToTaskStatus < ActiveRecord::Migration
  def change
    add_column :task_statuses, :view_priority, :integer
  end
end
