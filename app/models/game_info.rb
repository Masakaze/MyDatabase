class GameInfo < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en
#  attr_accessible :game_genre_id

  belongs_to :game_genre
end
