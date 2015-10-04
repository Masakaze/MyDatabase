class GameInfo < ActiveRecord::Base
  attr_accessor :name_jp, :name_en
  attr_accessor :game_genre_id

  belongs_to :game_genre
end
