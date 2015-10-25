class CreateGameKeyConfigs < ActiveRecord::Migration
  def change
    create_table :game_key_configs do |t|
      t.integer :game_platform_id
      t.integer :game_info_id

      t.timestamps null: false
    end

    add_foreign_key :game_key_configs, :game_platforms, column: :game_platform_id
    add_foreign_key :game_key_configs, :game_infos, column: :game_info_id
  end
end
