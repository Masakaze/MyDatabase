# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# GameGenreの初期化
init_game_genres = [
                   {:name_jp => "アクション", :name_en => "Action"},
                   {:name_jp => "RPG", :name_en => "RPG"},
                  ]
init_game_genres.each { |info|
  genre = GameGenre.find_by(name_en: info[:name_en])
  next if genre != nil

  genre = GameGenre.new(name_en: info[:name_en], name_jp: info[:name_jp])
  genre.name_jp = info[:name_jp]

  if genre.save == false
    abort("GameGenre:#{genre.name_en}の初期化に失敗")
  else
    puts "Add Genre"
    p genre
  end
}


# GamePlatformの初期化
init_game_platforms = [
                       {:name_en => "PS4"},
                       {:name_en => "WiiU"},
                  ]
init_game_platforms.each { |info|
  platform = GamePlatform.find_by(name_en: info[:name_en])
  next if platform != nil

  platform = GamePlatform.new(info)

  if platform.save == false
    abort("GamePlatform:#{platform.name_en}の初期化に失敗")
  else
    puts "Add Platform"
    p platform
  end
}

# GameKeyTypeの初期化
init_game_key_type_infos = {
  :PS4 => [
           {:name_en => "Square", :sign => "四角"},
           {:name_en => "Triangle", :sign  => "三角"},
           {:name_en => "Circle", :sign => "丸"},
           {:name_en => "Cross", :sign => "バツ"},
  ],
  :WiiU => [
            {:name_en => "A", :sign => "A"},
            {:name_en => "B", :sign => "B"},
            {:name_en => "X", :sign => "X"},
            {:name_en => "Y", :sign => "Y"},
  ],
}

init_game_key_type_infos.each { |platform_name, init_infos|
  platform = GamePlatform.find_by(:name_en => platform_name)
  abort("GamePlatformに#{platform_name}はありません") if platform == nil

  init_infos.each { |init_info|
    init_info[:game_platform_id] = platform.id
    game_key_type = GameKeyType.find_or_create_by(:name_en => init_info[:name_en], :game_platform_id => init_info[:platform_id])
    game_key_type.update_attributes(init_info)
    abort("GameKeyTypeの保存に失敗しました\n#{game_key_type.errors.messages}") if game_key_type.save() == false
  }
}

init_game_action_infos = [
                          {:name_jp => "ジャンプ", :name_en => "Jump"},
                          {:name_jp => "ダッシュ", :name_en => "Dash"},
                         ]
init_game_action_infos.each { |init_info|
  game_action = GameAction.find_or_create_by(:name_en => init_info[:name_en])
  game_action.update_attributes(init_info)
  abort("GameActionの保存に失敗\n#{game_action.errors.messages}") if game_action.save() == false
}
