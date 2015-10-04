class CreateGameInfos < ActiveRecord::Migration
  def change
    create_table :game_infos do |t|
      t.string :name_jp
      t.string :name_en

      t.timestamps null: false
    end
  end
end
