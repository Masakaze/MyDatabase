class CreateGameActions < ActiveRecord::Migration
  def change
    create_table :game_actions do |t|
      t.string :name_jp
      t.string :name_en

      t.timestamps null: false
    end

    add_column :game_keys, :game_action_id, :integer
    add_foreign_key :game_keys, :game_actions, column: :game_action_id
  end
end
