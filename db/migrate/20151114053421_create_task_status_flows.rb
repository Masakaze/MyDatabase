class CreateTaskStatusFlows < ActiveRecord::Migration
  def change
    create_table :task_status_flows do |t|
      t.integer :next_id
      t.integer :prev_id

      t.timestamps null: false
    end

    add_foreign_key :task_status_flows, :task_statuses, column: :next_id
    add_foreign_key :task_status_flows, :task_statuses, column: :prev_id

    add_column :task_statuses, :task_status_flow_id, :integer
  end
end
