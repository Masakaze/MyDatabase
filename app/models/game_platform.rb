class GamePlatform < ActiveRecord::Base

  has_and_belongs_to_many :game_infos
end
