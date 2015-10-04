json.array!(@game_infos) do |game_info|
  json.extract! game_info, :id, :name_jp, :name_en
  json.url game_info_url(game_info, format: :json)
end
