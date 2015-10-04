json.array!(@game_genres) do |game_genre|
  json.extract! game_genre, :id, :name_jp, :name_en
  json.url game_genre_url(game_genre, format: :json)
end
