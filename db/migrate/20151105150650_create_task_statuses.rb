class CreateTaskStatuses < ActiveRecord::Migration
  def change
    create_table :task_statuses do |t|
      t.string :name_jp

      t.timestamps null: false
    end

    add_column :task_infos, :task_status_id, :integer
    add_foreign_key :task_infos, :task_statuses, column: :task_status_id
  end
end
