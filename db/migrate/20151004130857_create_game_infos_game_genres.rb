class CreateGameInfosGameGenres < ActiveRecord::Migration
  def change
    create_table :game_infos_game_genres do |t|
      t.integer :game_info_id
      t.integer :game_genre_id
    end
  end
end
