class GameGenre < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en

  has_many :game_infos

end
