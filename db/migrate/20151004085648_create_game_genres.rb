class CreateGameGenres < ActiveRecord::Migration
  def change
    create_table :game_genres do |t|
      t.string :name_jp
      t.string :name_en

      t.timestamps null: false
    end

    # GameInfoにGameGenreの外部キー追加
    add_column :game_infos, :game_genre_id, :integer
    add_foreign_key :game_infos, :game_genres, column: :game_genre_id
  end
end
