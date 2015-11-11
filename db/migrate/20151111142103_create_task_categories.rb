class CreateTaskCategories < ActiveRecord::Migration
  def change
    create_table :task_categories do |t|
      t.string :name_jp

      t.timestamps null: false
    end

    add_column :task_infos, :task_category_id, :integer
    add_foreign_key :task_infos, :task_categories, column: :task_category_id
  end
end
