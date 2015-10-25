class GamePlatform < ActiveRecord::Base

  has_and_belongs_to_many :game_infos
  has_many :game_key_types
  has_many :game_key_configs
end
