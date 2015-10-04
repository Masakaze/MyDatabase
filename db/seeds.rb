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
