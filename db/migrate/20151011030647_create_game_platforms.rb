class CreateGamePlatforms < ActiveRecord::Migration
  def change
    create_table :game_platforms do |t|
      t.string :name_en

      t.timestamps null: false
    end

    create_table :game_infos_platforms do |t|
      t.integer :game_info_id
      t.integer :game_platform_id
    end
  end
end
