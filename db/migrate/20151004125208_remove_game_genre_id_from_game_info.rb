class RemoveGameGenreIdFromGameInfo < ActiveRecord::Migration
  def change
    remove_foreign_key :game_infos, column: :game_genre_id
    remove_column :game_infos, :game_genre_id
  end
end
