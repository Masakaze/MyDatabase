class GameInfo < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en
#  attr_accessible :game_genre_id

  has_and_belongs_to_many :game_genres
  has_and_belongs_to_many :game_platforms
end
