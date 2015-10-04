class GameGenre < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en

  has_and_belongs_to_many :game_infos

end
