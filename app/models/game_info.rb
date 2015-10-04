class GameInfo < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en
#  attr_accessible :game_genre_id

  has_many_and_belongs_to :game_genres
end
