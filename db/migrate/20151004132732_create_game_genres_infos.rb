class CreateGameGenresInfos < ActiveRecord::Migration
  def change
    create_table :game_genres_infos do |t|
      t.integer :game_info_id
      t.integer :game_genre_id
    end
  end
end
